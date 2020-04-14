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
![Trade cycle activities](../img/in-post/Exhibit%202.1.Trade%20cycle%20activities.jpg)
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

![Positive Broker Value](../img/in-post/Positive%20Broker%20Value.jpg)

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








 






