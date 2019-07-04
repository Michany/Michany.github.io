import abc
class Derivative(Simulator):
    def __init__(self, S_0=100, T=1, rf=0.04, sigma=0.2, steps=250 ):
        super().__init__(S_0=100, T=1, rf=0.04, sigma=0.2, steps=250)
    @abc.abstractmethod
    def payoff(self, T, underlying_path):
        return 
    def pricing(self, T, underlying_path,r):
        price_sim = self.payoff(T, underlying_path) * np.exp(-r*T)
        return np.mean(price_sim)
        
class EuropeanOption(Derivative):
    def __init__(self,S_0=100, T=1, rf=0.04, sigma=0.2, steps=250):
        super().__init__(S_0=100, T=1, rf=0.04, sigma=0.2, steps=250)
    def payoff(self,**kwargs):
        self.geometric_brownian_motion()
        strike = kwargs["strike"]
        S_0, T, r, sigma, steps = self.unpack_params(kwargs)
        price_sim = max(self.path - strike, 0) * np.exp(-r*T)
        return price_sim.mean()
eo = EuropeanOption(S_0=100, T=1, rf=0.04, sigma=0.2, steps=250)        
