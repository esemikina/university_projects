from common.np import *  # import numpy as np
from common.config import GPU
from common.functions import softmax, cross_entropy_error, check_loss


class MatMul:
    '''
    matrix multiply layer
    '''
    def __init__(self, W):
        self.params = [W]
        self.grads = [np.zeros_like(W)]
        self.x = None

    def forward(self, x):
        W, = self.params
        out = np.dot(x, W)
        self.x = x
        return out

    def backward(self, dout):
        W, = self.params
        dx = np.dot(dout, W.T)
        dW = np.dot(self.x.T, dout)
        self.grads[0][...] = dW    # deep copy
        return dx


class Affine:
    '''
    affine layer
    '''
    def __init__(self, W, b):
        self.params = [W, b]
        self.grads = [np.zeros_like(W), np.zeros_like(b)]
        self.x = None

    def forward(self, x):
        W, b = self.params
        out = np.dot(x, W) + b
        self.x = x
        return out

    def backward(self, dout):
        W, b = self.params
        dx = np.dot(dout, W.T)
        dW = np.dot(self.x.T, dout)
        db = np.sum(dout, axis=0)

        self.grads[0][...] = dW
        self.grads[1][...] = db
        return dx


class Softmax:
    '''
    softmax layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.out = None

    def forward(self, x):
        self.out = softmax(x)
        return self.out

    def backward(self, dout):
        dx = self.out * dout
        sumdx = np.sum(dx, axis=1, keepdims=True)
        dx -= self.out * sumdx
        return dx


class SoftmaxWithLoss:
    '''
    softmax-with-loss layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.y = None  # softmax output
        self.t = None  # supervised label

    def forward(self, x, t):
        self.t = t
        self.y = softmax(x)

        # when the supervised labels are one-hot vectors, 
        # convert to the index of the correct solution label
        if self.t.size == self.y.size:
            self.t = self.t.argmax(axis=1)

        loss = cross_entropy_error(self.y, self.t)
        return loss

    def backward(self, dout=1):
        batch_size = self.t.shape[0]

        dx = self.y.copy()
        dx[np.arange(batch_size), self.t] -= 1
        dx *= dout
        dx = dx / batch_size

        return dx


class Sigmoid:
    '''
    sigmoid layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.out = None

    def forward(self, x):
        out = 1 / (1 + np.exp(-x))
        self.out = out
        return out

    def backward(self, dout):
        dx = dout * (1.0 - self.out) * self.out
        return dx


class ReLU:
    '''
    relu layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.out = None
        
    def forward(self, x):
        self.input = x
        self.out = np.maximum(0, x)
        return self.out
    
    def backward(self, dout):
        self.dx = dout.copy()
        self.dx[self.input <= 0] = 0
        return self.dx


class SigmoidWithLoss:
    '''
    sigmoid-with-loss layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.loss = None
        self.y = None  # sigmoid output
        self.t = None  # supervised label

    def forward(self, x, t):
        self.t = t
        self.y = 1 / (1 + np.exp(-x))

        self.loss = cross_entropy_error(np.c_[1 - self.y, self.y], self.t)

        return self.loss

    def backward(self, dout=1):
        batch_size = self.t.shape[0]

        dx = (self.y - self.t) * dout / batch_size
        return dx
    

class MSELoss:
    '''
    mean squared error loss layer
    '''
    def __init__(self):
        self.params, self.grads = [], []
        self.loss = None
        self.y_pred = None  
        self.y_true = None  # true response
        
    def forward(self, y_pred, y_true):
        if y_true.ndim == 1:
            y_true = y_true.reshape(y_pred.shape)
        self.y_pred = y_pred
        self.y_true = y_true
        self.loss = np.mean((y_true - y_pred) ** 2)
        return self.loss
    
    def backward(self, dout=1):
        batch_size = self.y_true.shape[0]
        dx = 2 * (self.y_pred - self.y_true) * dout / batch_size
        return dx
    

class CheckLoss:
    '''
    check loss layer
    '''
    def __init__(self, tau=0.5):
        self.params, self.grads = [], []
        self.loss = None
        self.y_pred = None  
        self.y_true = None  # true response
        self.tau = tau
        
    def forward(self, y_pred, y_true):
        if y_true.ndim == 1:
            y_true = y_true.reshape(y_pred.shape)
        self.y_pred = y_pred
        self.y_true = y_true
        self.loss = check_loss(y_true - y_pred, self.tau)
        return self.loss
    
    def backward(self, dout=1):
        batch_size = self.y_true.shape[0]
        dx = -1 * np.where(self.y_true > self.y_pred, self.tau, self.tau-1)  \
             * dout / batch_size
        return dx


class Dropout:
    '''
    http://arxiv.org/abs/1207.0580
    '''
    def __init__(self, dropout_ratio=0.5):
        self.params, self.grads = [], []
        self.dropout_ratio = dropout_ratio
        self.mask = None

    def forward(self, x, train_flg=True):
        if train_flg:
            self.mask = np.random.rand(*x.shape) > self.dropout_ratio
            return x * self.mask
        else:
            return x * (1.0 - self.dropout_ratio)

    def backward(self, dout):
        return dout * self.mask


class Embedding:
    def __init__(self, W):
        self.params = [W]
        self.grads = [np.zeros_like(W).astype('f')]
        self.idx = None

    def forward(self, idx):
        W, = self.params
        self.idx = idx
        out = W[idx]
        return out

    def backward(self, dout):
        dW, = self.grads
        dW[...] = 0
        if GPU:
            np.scatter_add(dW, self.idx, dout)
        else:
            np.add.at(dW, self.idx, dout)
        return None