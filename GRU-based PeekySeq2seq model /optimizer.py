import sys
sys.path.append('..')
from common.np import *

class SGD:
    '''
    Stochastic Gradient Descent (SGD)
    '''
    def __init__(self, lr=0.01):
        self.lr = lr
        
    def update(self, params, grads):
        for i in range(len(params)):
            params[i] -= self.lr * grads[i]


class decaySGD:
    '''
    SGD with a decay learning rate
    '''
    def __init__(self, lr=0.1, decay_rate=0.99):
        self.lr = lr
        self.current_lr = lr
        self.decay_rate = decay_rate
        self.iter = 0
        
    def update(self, params, grads):
        if self.decay_rate<1:
            self.current_lr = self.lr / (1. + (1-self.decay_rate) * self.iter)
    
        for i in range(len(params)):
            params[i] -= self.current_lr * grads[i]
        
        self.iter += 1

            
class Momentum:
    '''
    SGD with Momentum
    * SGD has trouble navigating ravines
    * Momentum [Qian, 1999] helps SGD accelerate
    * A fraction gamma of the update vector at step t-1 is added to the gradient
    * v[t] = gamma * v[t-1] + lr * grad[t]
    * para[t+1] = para[t] - v[t]
    '''
    def __init__(self, lr=0.01, momentum=0.9):
        self.lr = lr
        self.momentum = momentum
        self.v = None
        
    def update(self, params, grads):
        if self.v is None:
            self.v = []
            for param in params:
                self.v.append(np.zeros_like(param).astype('f'))

        for i in range(len(params)):
            self.v[i] = self.momentum * self.v[i] - self.lr * grads[i]
            params[i] += self.v[i]


class Nesterov:
    '''
    Nesterov's Accelerated Gradient (http://arxiv.org/abs/1212.0901)
    '''
    def __init__(self, lr=0.01, momentum=0.9):
        self.lr = lr
        self.momentum = momentum
        self.v = None
        
    def update(self, params, grads):
        if self.v is None:
            self.v = []
            for param in params:
                self.v.append(np.zeros_like(param).astype('f'))

        for i in range(len(params)):
            self.v[i] *= self.momentum
            self.v[i] -= self.lr * grads[i]
            params[i] += self.momentum * self.momentum * self.v[i]
            params[i] -= (1 + self.momentum) * self.lr * grads[i]


class AdaGrad:
    '''
    AdaGrad (Adaptive Gradient)
    * per-parameter learning rate instead of a globally-shared rate
    * let less-frequently updated parameters to keep-up with changes
    * effectively use more neurons for training
    * cache += grads ** 2
    '''
    def __init__(self, lr=0.01):
        self.lr = lr
        self.h = None
        
    def update(self, params, grads):
        if self.h is None:
            self.h = []
            for param in params:
                self.h.append(np.zeros_like(param).astype('f'))

        for i in range(len(params)):
            self.h[i] += grads[i] * grads[i]
            params[i] -= self.lr * grads[i] / (np.sqrt(self.h[i]) + 1e-7)


class RMSprop:
    '''
    RMSprop (Root Mean Square Propagation)
    * calculates an adaptive learning rate per parameter
    * adds a mechanism similar to momentum but also adds a
      per-parameter adaptive learning rate, so the learning 
      rate changes are smoother
    * instead of continually adding squared gradients to a cache
      (like in Adagrad), it uses a moving average of the cache
    * cache = decay_rate * cache + (1 - decay_rate) * grads ** 2
    '''
    def __init__(self, lr=0.01, decay_rate = 0.99):
        self.lr = lr
        self.decay_rate = decay_rate
        self.h = None
        
    def update(self, params, grads):
        if self.h is None:
            self.h = []
            for param in params:
                self.h.append(np.zeros_like(param).astype('f'))

        for i in range(len(params)):
            self.h[i] *= self.decay_rate
            self.h[i] += (1 - self.decay_rate) * grads[i] * grads[i]
            params[i] -= self.lr * grads[i] / (np.sqrt(self.h[i]) + 1e-7)


class Adam:
    '''
    Adam (Adaptive Momentum, http://arxiv.org/abs/1412.6980v8)
    * currently the most widely-used optimizer and is built atop RMSProp,
      with the momentum concept from SGD added back in
    * instead of applying current gradients, apply momentums like in the 
      SGD optimizer with momentum, then apply a per-weight adaptive learning 
      rate with the cache as done in RMSProp
    * The Adam optimizer additionally adds a bias correction mechanism:
      both momentum and caches are divided by 1 - beta ** niter
    '''
    def __init__(self, lr=0.001, beta1=0.9, beta2=0.999):
        self.lr = lr
        self.beta1 = beta1
        self.beta2 = beta2
        self.iter = 0
        self.m = None
        self.v = None
        
    def update(self, params, grads):
        if self.m is None:
            self.m, self.v = [], []
            for param in params:
                self.m.append(np.zeros_like(param).astype('f'))
                self.v.append(np.zeros_like(param).astype('f'))
        
        self.iter += 1
        lr_t = self.lr * np.sqrt(1.0 - self.beta2**self.iter) / (1.0 - self.beta1**self.iter)

        for i in range(len(params)):
            self.m[i] += (1 - self.beta1) * (grads[i] - self.m[i])
            self.v[i] += (1 - self.beta2) * (grads[i]**2 - self.v[i])
            
            params[i] -= lr_t * self.m[i] / (np.sqrt(self.v[i]) + 1e-7)
