---
layout: post
title: "Essences of Trading Books"
subtitle: "Electronic and Algorithmic Trading Technology - The Complete Guide"
author: "Michael Wang"
header-img: "img/home-bg-art.jpg"
header-mask: 0.3
mathjax: true
catalog: true
tags:
  - Trading
  - Quant
---


-------------------------

# Introduction

## Basic Terminology

### Distinguish among electronic trading, program trading, and algorithmic trading
- Electronic Trading: 通过电子的方式进行交易，代替Human Voice Brokage
- Program Trading: 交易一揽子股票
- Algorithm Trading: 包含拆单等方式，以达到最优执行价  
  也叫做black box trading

# Overview 
## Electronic Trading
### The Emergence of Electronic Trading Networks
2001年，纽交所采用了十进制，把最小交易单位从1/16改成了0.01，减少了84%的Trading Margins。由此，OrderBook变得更加*细碎*，Algorithmic trading has become a solution for the problem of smaller spreads and market fragmentation.

> **Financial Information Exchange (FIX) Protocol**  
> A series of messaging specifications for electronic communication protocol international real-time exchange of securities transactions in the finance markets.  
> **Electronic communication networks (ECNs)**  
> This collects limit and market orders and matches them or displays them on an Internet-based orderbook.

## Algorithmic Trading
### Participants
算法交易的参与者主要是如下两类：
1. Sell-side Brokerage Firms (60%) 
   一开始开发给自营交易，后来提供给大的买方机构，出现了很多 customized algorithms 
2. Agency Brokers (30%)  
   和BB行竞争份额，导致佣金收入不断降低。  
3. Hedge Fund and others (10%)  
   自己编写算法进行交易

> **The role of A Sales Trader**  
> Sales traders will increasingly offer consulting services advising how clients should get the best execution depending on market conditions as opposed to their traditional role of providing the execution service themselves  
> 从传统的“交易执行服务” -> 根据市场环境"提供算法交易策略的建议"

### Trends
- 更小的Spread
- 更低的Commission
- 更小的Trade Size

### Associated Trading Strategies
1. Duration Averaging  
   类似于区间交易
2. Portfolio insurance or dynamic hedging  
   市场下跌时抛售一揽子股票
3. Index arbitrage
   指数现货（一揽子）和指数衍生品之间的套利

> **Def. Algorithmic trading**   
> placing a buy or sell order of a defined quantity into a quantitative model that automatically generates the timing of orders and the size of orders based on goals specified by the parameters and constraints of the algorithm.’

### 5 basic algorithms

1. Volume-weighted average price (VWAP)
2. Time-weighted average price (TWAP) 
3. Implementation shortfall or arrival price
4. Volume participation
5. Smart routing methods

## Programed Trading 
从80年代开始，每次市场暴跌，程序化交易总是背锅。但实际上市场恐慌暴跌的真正原因：
1. **Risk effect** 更高的波动导致股票风险增加，反过来压低股价。
2. **Wealth effect**股价下跌导致投资者资产受损，转为risk-off以避免更高的波动。
3. **Diversification effect** 市场一齐下跌，导致股票之间Cov增加，系统性风险无法被分散。
4. **Liquidity effect** 流动性紧张，导致即便股价处于低位，大家也都想要卖出（以防将来卖不出去）

1987年开始，有了熔断机制 (Circuit breakers)。

# Automating Trade and Order Flow
## Trading Process
### Trade cycle
![Trade cycle activities](/img/in-post/Exhibit%202.1.Trade%20cycle%20activities.jpg)
- Trade: 前台执行交易。这时候就要看Trader水平了。当价差大、流动性差的时候，Trader的决策会带来更多added-value on execution
- Post-Trade：后台核查交易(Confirmation)、簿记(Accounting)、清算(Clearing)、对帐 (Reconciliation)、交收(Settlement)

> **Transaction cost analysis (TCA)**


### Research Service
尽管受到很多监管，但大买方还是很重视研报服务，通过Soft Dollars来付钱。
> **Soft dollars** are commission payment agreements between brokers and their investment management clients to fund research and investment-related services. Soft dollars enable the money manager to compensate the broker for the value of research tied in to transaction costs.

### Order Management Systems (OMS)
从Portfolio Managers那边接收订单，然后聚合并且分配给Traders（类似于根网系统？）

OMS需要具备的关键功能
1. Trade blotter (吸墨纸？)
   Central Hub, 把订单都收集起来
2. Prepackaged algorithms  
   预先设计好的交易算法，必须有足够的定制化能力
3. Pre- and post-trade analytics  
   Pre-trade: 让交易员估计用哪种算法
   Post-trade: 可以基于Benchmark来分析哪种更好
4. Multiple asset classes
5. Compliance and regulatory reporting

### Order Routing
买方公司来决定Order流向哪些经纪商（往往根据谁的手续费低），现在越来越多地用算法来完成这些事情。而且，有了越来越完善的DMA系统，买方交易员可以直接绕开sales trader，进行Low-touch下单。因此，卖方必须加倍专精于他们的领域，**Sales Trader的工作也拓展到“帮助定制交易算法”“提供算法交易和模型建议”等等**。
> The sales trader’s role can expand to helping buy-side traders deter-mine how to customize algorithms, helping determine which models to use,and providing customization advice.

在算法交易的大环境下，卖方很挣扎。2004-2007年佣金费率下降了20%。大家佣金都越来越便宜，买方做选择也失去了意义。卖方必须转型，开始提供算法交易的咨询服务， 
> Brokers will shift from order takers looking for the best execution to idea providers.   
> A new trend in services will come about, such as algorithmic trading consultants and service provider.

![Positive Broker Value](/img/in-post/Positive%20Broker%20Value.jpg)

# The Growth of Program and Algorithmic Trading

## Trend
程序化交易的比例越来越高，同时大宗交易的比例越来越低。

Year | Total % of   Program Trades on the NYSE | % of Buy Programs   on the NYSE | % of Sell   Programs on the NYSE
-- | -- | -- | --
2004 | 50.60% | 25.80% | 24.70%
2003 | 37.50% | 19.20% | 18.30%
2002 | 32.20% | 16.80% | 15.50%
2001 | 27.80% | 14.60% | 13.20%
2000 | 22.00% | 11.30% | 10.70%
1999 | 19.70% | 9.80% | 9.90%
1998 | 17.50% | 9.00% | 8.50%
1997 | 16.80% | 8.60% | 8.10%
1996 | 13.30% | 6.90% | 6.50%
1995 | 11.60% | 6.40% | 5.20%

## Program Trade Example
Steps to trade a portfolio, trying to achieve quality executions while minimizing market impact.
### 分析交易的成份股和其流动性
**Determining the optimal tranche size and generating pre-trade liquidity.**   
一般来说，交易量<35% ADV (Average Daily Volume)，可以被放入一揽子交易。ADV一般有过去20天的交易量来决定。

一张典型的一揽子交易单如下，可以看到这是一个流动性较好的组合。

ADV% Lower | ADV% Upper | Stocks | Shares | $   Value | Weight
-- | -- | -- | -- | -- | -- | -- | -- | -- | --
0.0% | 0.5% | 53 | 24,934 | 3,717,268 | 1.24%
0.5% | 2.5% | 38 | 6,545,310 | 162,036,173 | 54.01%
2.5% | 5.0% | 6 | 6,686,544 | 116,923,962 | 38.97%
5.0% | 10.0% | 0 | 687,634 | 15,834,422 | 5.28%
10.0% | 15.0% | 1 | 0 | 0 | 0.00%
15.0% | 20.0% | 0 | 554,157 | 1,515,236 | 0.51%
20.0% | 30.0% | 0 | 0 | 0 | 0.00%
30.0% | 40.0% | 0 | 0 | 0 | 0.00%
40.0% | 50.0% | 0 | 0 | 0 | 0.00%
Total || 100 | 14,498,579 | 300,027,060 | 100.00%

## Market Growth and IT Spending

算法交易额增长最快的是传统买方（CAGR=49.8%），而对冲基金和卖方在交易额上的增长稳定。

IT花销上的增长约为11%。

# Alternative Execution Venues
2000年，Rule 390被撤销。Rule 390本来是禁止上市公司在非交易所交易的，因此现在Market Dealer可以接更多的订单流，然后达成内部成交。这件事情利好BB行，利空交易所。

> **Alternative execution venues**  
> Large bulge-bracket firms are steering U.S. stock trades  away  from  the  exchanges  routing  them  to  their internal systems. 很多BB行绕开交易所，把订单引入自己的系统来成交。（这是个趋势）

> **The NYSE Group,Inc**  
> The NYSE Group is a leading provider of securities listing, trading, and market data products and services. NYSE集团旗下有纽约证券交易所，占80%的交易量。

# Algorithmic Strategies 
前情提要：随着电子/算法交易在全市场的普及，卖方不得不收取更低的Soft dollars和Commission来维系和买方的关系，因为买方更加倾向于去最高效的场所交易，而不是局限于去找卖方交易（尽管卖方能提供一些研究报告）。

## Algorithm penetration
### Pre-trade analysis 
接到一笔的交易，首先考虑是否可接受，随即就要考虑宏观和微观上的问题。
宏观上主要是标的价格随市场波动的问题，微观上主要是考虑流动性、订单大小、等待时长和订单修改与取消的规则等等。
> **Pricing Schemes**  
> Share quantities,  wait  periods  between  order submissions, revisions, and cancellations

现在跟多交易单都会包含一个参考价（例如bid，ask，mid），这样就能更好地用上预先优化好的算法（可以调整激进、保守的风格参数）。

## Benchmark
Benchmark也可以分为 pre-, intra-, post-trade prices 这三类
- **Pre-trade prices** (AKA. implementation shortfall 执行差额)  
  Previous night’s closing price, opening price, and price at the time of order entry  
- **Intra-trade benchmark**  
  Prices that occur during a trading session, at the average of open, high, low, or close
- **Post-trade analysis**  
  Cost: the difference  between  the  actual  realized  execution  price  and  the  specified benchmark  price.  

## Implementation Shortfall
下面三个portfolio分别表示不同的交易结果
1. Paper portfolio
   顾名思义，理论上的价格，没有交易成本
2. Actual portfolio
   实际的价格，有很高的交易成本
3. Rabbit portfolio
   交易成本介于上面两者之间，用于衡量交易的表现

### 例
要买700股，分3天买。最终还是少买了100股。

Day | Price of Close | Trade Price | Number of Shares
-- | -- | -- | --
0 | $100.00 | $100.00 | 0
1 | $102.00 | $101.00 | 300
2 | $102.50 | $101.75 | 200
3 | $102.75 | $102.50 | 100

计算理想的组合收益和实际的组合收益，差值即为Implementation shortfall
![Implementation shortfall example](/img/in-post/Implementation%20shortfall%20example.jpg)

## Volume-Weighted Average Price
VWAP一直是评判交易算法的一个主要Benchmark。例如买入均价高于VWAP，则认为是表现差。这样的评价方式，鼓励trader更加倾向于将订单分拆到整个交易时段，来保证自己不会在某些极端价格成交。

> **Multi-day VWAP**  
> specify their own volume participation  by  limiting  the  volume  of  their  orders  on  low  expected volume days. 
> 把订单分拆到每天，每天的量根据预估的成交量来分配。

注意，对于不同的投资风格，可能交易成本天生就有不同。  
价值投资者，会在估值低位购买股票，等待股票上涨后卖出，则其与市场反方向操作；成长投资者会追涨杀跌，交易成本本身就很高。

### Definition

- Full VWAP: 总金额/总股数
- VWAP excluding own transactions: 除自己交易外的VWAP，可能有偏误
- Non-block VWAP: 除大宗交易
- VWAP proxies: 当某些市场中，tick级数据不可用时，用平均值来代替。
- Value-weighted average price: 用每笔交易金额对价格加权，可以用于volatile securities

### Strategies
- Guaranteed principal VWAP bid: 由大型broker-dealer提供服务，收取较低的佣金，保证VWAP交易，承担价格波动的风险。  
  对买方来说，缺点是可能会有信息泄露，也可能是broker本身也想要购买同样的股票（可以拉升股价然后收取更高的VWAP价格？）
- Forward VWAP cross  
  无法保证VWAP
- Automated participation strategy: 可暂停、交易成本低、可定制  
  缺点是无法保证VWAP，在极端情况下会出现shortfalls

## Time-Weighted Average Price
以TWAP为标准，不受交易量的影响，在流动性差的股票上也能保证高的订单完成率。

## Algorithm Market Share (2005)
![Algorithm Market Share](/img/in-post/Algorithm%20Market%20Share.jpg)


# Algorithmic Feasibility and Limitations

## Trade Structure
> structured approach involves tracking strategies based on historical data, or strategy benchmarks, while unstructured liquidity is generally associated with real-time information or price benchmarks. 

用什么样的structure的决定因素：
1. Trade Horizon: 交易时间短的，用什么交易算法都差不多
2. Need to finish: 订单完成率要求较高的，必须使用更加复杂的结构
3. Predictability: 从平均值、标准差等角度去估计
4. Price Sensitivity: 价格敏感性高的话，Structure就变得没用了。短期和实时的波动率要作为参数输入。
5. Rick Tolerance: 风险容忍度高的话，就不需要花大力气去structuring

## Algorithmic Feasibility
不是所有的订单都适合用算法交易。
- VWAP不关心订单大小，当超过ADV时就很危险。
- 同时，交易量太小的时候，用算法拆分订单还不如直接交易，算上时间成本的话。
>  **Opportunity cost** can be defined as the standard deviation of the trading cost.
>  This is a function of trade distribution, stock volatility, and correlation among stocks  on a trade list over a given time frame   

Volume participation algorithm 可以减少这种机会成本。这种方式可以最小化supply and demand imbalances，但是别的因素（例如spread）仍然会有影响。VP其实是固定交易比率，但不知道总的交易量多少。

## Newsflow Algorithms
新兴的交易算法减少了VWAP基准，而是更多用post-trade data来做文章。比如Newsflow这种算法，把新闻的情绪也纳入指标中，和流动性等其他指标一起考虑。

# Minimizing Execution Costs

> Implementation Shortfall = Cost due to manager’s delay + Explicit costs + Implicit costs + Opportunity costs

## Components of Trading Costs
### Bid-ask Spread
大公司（例如Fidelity）的trading cost大约在1%不到，其比较的基准是下单时bid-ask的中间价。

### Costs and Management Style
前面也提到，不同的投资风格，造成交易成本有很大差异。


Management   Style | Trade Motivation | Liquidity Demands | Execution Costs | Opportunity Costs
-- | -- | -- | -- | --
Value | Value | Low | Low | Low
Growth | Value | Low | Low | Low
Earnings Surprise | Information | High | High | High
Index-Fund Large-Cap | Passive | Variable | Variable | High
Index-Fund Small-Cap | Passive | High | High | High

### The Cost of Waiting  
使用算法分拆订单，会需要等待更多的时间来执行。等待的成本大小取决于：
- 是否是根据公开信息做交易？If not, 等待的成本很高
- 是否有别的类似投资者？
- 是长期还是短线交易？
- 是动量/反转策略？动量策略的等待成本高，反转交易的等待成本相对较低。
  
### Explicit Costs—Commissions, Fees, and Taxes
这些成本都是不可避免的。但是Commission在不断降低。

## 常用算法小结

> **VWAP**  
> Attempts to minimize tracking error while maximizing performance  versus  the  Volume-Weighted  Average  Price.  Similar to simple time slicing, but aims to minimize spread and impact costs.

> **TWAP**  
> Aims to match the Time-Weighted Average Price. Similar to simple time slicing, but aims to minimize spread and impact costs.

> **Participate** AKA. **Inline**, Follow, With Volume, POV.   
> Aims to be a user-specified fraction of the volume traded in the market.

> **MOC**  
> Enhanced  MOC  strategy  that  optimizes  risk  and  impact, possibly starting trading before the closing auction.

> **Implementation shortfall** or arrival price Manages  
> the  trade-off between impact and risk to execute as close as possible to the mid point when the order is entered.

> **Pegging**   
> An order sent out at the best bid (ask) if buying (selling),and if the price moves, the order is modified accordingly  
> 盘口挂单，按时撤掉重挂

# Trading Technology and Prime Brokerage

> **Black box**  
> refers  to  computer programs that focus on a combination of real-time market data and fundamentals to derive buy and sell signals.  
> Mathematicians or quants have programs capable of analyzing large amounts of financial data, which allow them to profit from small gains made off brief imbalances in the market.


## Prime Broker Services

> **Prime brokers**  
> provide technological support, ensure access to markets, develop synthetic products, and provide operational functions for settlements, custody, and reporting for buy-side trades  
> Custody  activity  in  facilitate  margin-lending  and the associated movement of collateral

PB给对冲基金提供的主要的服务：
1. Margin Management 
   计算保证金要求
2. Securities lending 
   融券服务
3. Clearance and settlements 
   交收
4. Execution access 
5. Automated confirmation and reconciliation 
   提供订单执行的回报，给买方的中台
6. Integrated daily position report
   提供每日执行报告

![Hedge Fund Execution Flow](/img/in-post/Hedge%20Fund%20Execution%20Flow.jpg)

### Securities lending
证券存在托管行(Custodians)，托管行借给Broker，Broker保证按时归还。  
然后Broker转手借给公开市场，一般由一个 lending-desk 的 broker-dealer来设定rebate rate（借券人的保证金的利息）。这个rebate rate设定很有讲究，比较难借到的券，rate有可能是负数，也就是说出借人能收取一定的费用。

### Margin
不同的投资策略，一般使用的杠杆率也不一样，低风险的套利策略杠杆率较高。

Strategy | Do Not Use | Low(<2:1) | High(>2:1)
-- | -- | -- | --
Aggressive   Growth | 20% | 60% | 20%
Emerging Markets | 20 | 50% | 30%
Equity Market Neutral | 15% | 50% | 35%
Event Driven | 15% | 60% | 25%
Income | 35% | 30% | 35%
Macro | 10% | 30% | 60%
Market Neutral Arbitrage | 10% | 25% | 65%
Market Timing | 55% | 35% | 10%
Multi-Strategy | 10% | 50% | 40%
Opportunistic | 10% | 60% | 30%
Short Selling | 30% | 40% | 30%
Value | 20% | 60% | 20%

题外话，这思维导图画的还真是简明
![Competitive landscape](/img/in-post/Competitive%20landscape.jpg)



