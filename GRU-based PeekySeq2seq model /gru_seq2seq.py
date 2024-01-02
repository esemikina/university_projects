import sys
sys.path.append('..')
from common.time_layers import *
from common.base_model import BaseModel


class Encoder:
    def __init__(self, vocab_size, wordvec_size, hidden_size):
        V, D, H = vocab_size, wordvec_size, hidden_size
        rn = np.random.randn

        embed_W = (rn(V, D) / np.sqrt(V)).astype('f')
        gru_Wx = (rn(D, 3 * H) / np.sqrt(D)).astype('f')  # GRU has 3 gates
        gru_Wh = (rn(H, 3 * H) / np.sqrt(H)).astype('f')
        gru_b = np.zeros(3 * H).astype('f')

        self.embed = TimeEmbedding(embed_W)
        self.gru = TimeGRU(gru_Wx, gru_Wh, gru_b, stateful=False)  # Replace LSTM with GRU

        self.params = self.embed.params + self.gru.params
        self.grads = self.embed.grads + self.gru.grads
        self.hs = None

    def forward(self, xs):
        xs = self.embed.forward(xs)
        hs = self.gru.forward(xs)  # Use GRU for forward
        self.hs = hs
        return hs[:, -1, :]

    def backward(self, dh):
        dhs = np.zeros_like(self.hs)
        dhs[:, -1, :] = dh

        dout = self.gru.backward(dhs)  # Use GRU for backward
        dout = self.embed.backward(dout)
        return dout


class Decoder:
    def __init__(self, vocab_size, wordvec_size, hidden_size):
        V, D, H = vocab_size, wordvec_size, hidden_size
        rn = np.random.randn

        embed_W = (rn(V, D) / np.sqrt(V)).astype('f')
        gru_Wx = (rn(D, 3 * H) / np.sqrt(D)).astype('f')  # GRU has 3 gates
        gru_Wh = (rn(H, 3 * H) / np.sqrt(H)).astype('f')
        gru_b = np.zeros(3 * H).astype('f')
        affine_W = (rn(H, V) / np.sqrt(H)).astype('f')
        affine_b = np.zeros(V).astype('f')

        self.embed = TimeEmbedding(embed_W)
        self.gru = TimeGRU(gru_Wx, gru_Wh, gru_b, stateful=True)  # Replace LSTM with GRU
        self.affine = TimeAffine(affine_W, affine_b)

        self.params, self.grads = [], []
        for layer in (self.embed, self.gru, self.affine):
            self.params += layer.params
            self.grads += layer.grads

    def forward(self, xs, h):
        self.gru.set_state(h)

        out = self.embed.forward(xs)
        out = self.gru.forward(out)  # Use GRU for forward
        score = self.affine.forward(out)
        return score

    def backward(self, dscore):
        dout = self.affine.backward(dscore)
        dout = self.gru.backward(dout)  # Use GRU for backward
        dout = self.embed.backward(dout)
        dh = self.gru.dh
        return dh

    def generate(self, h, start_id, sample_size):
        sampled = []
        sample_id = start_id
        self.gru.set_state(h)

        for _ in range(sample_size):
            x = np.array(sample_id).reshape((1, 1))
            out = self.embed.forward(x)
            out = self.gru.forward(out)  # Use GRU for forward
            score = self.affine.forward(out)

            sample_id = np.argmax(score.flatten())
            sampled.append(int(sample_id))

        return sampled


class GRUSeq2seq(BaseModel):
    def __init__(self, vocab_size, wordvec_size, hidden_size):
        V, D, H = vocab_size, wordvec_size, hidden_size
        self.encoder = Encoder(V, D, H)
        self.decoder = Decoder(V, D, H)
        self.softmax = TimeSoftmaxWithLoss()

        self.params = self.encoder.params + self.decoder.params
        self.grads = self.encoder.grads + self.decoder.grads

    def forward(self, xs, ts):
        decoder_xs, decoder_ts = ts[:, :-1], ts[:, 1:]

        h = self.encoder.forward(xs)
        score = self.decoder.forward(decoder_xs, h)
        loss = self.softmax.forward(score, decoder_ts)
        return loss

    def backward(self, dout=1):
        dout = self.softmax.backward(dout)
        dh = self.decoder.backward(dout)
        dout = self.encoder.backward(dh)
        return dout

    def generate(self, xs, start_id, sample_size):
        h = self.encoder.forward(xs)
        sampled = self.decoder.generate(h, start_id, sample_size)
        return sampled
