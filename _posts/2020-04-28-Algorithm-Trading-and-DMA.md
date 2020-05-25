---
layout: post
title: "Algorithmic Trading & OMA"
subtitle: "Essences of Trading Books"
author: "Michael Wang"
header-img: "img/post-bg-AlgoTrading.jpg"
header-mask: 0.3
mathjax: true
catalog: true
tags:
  - Trading
  - Quant
---


-------------------------

# [Chapter 1] Overview
## Trade Order Flow
![OrderFlow](/img/in-post/[AlgoTrading]OrderFlow.png)
首先，Buy side 决定一个下单，图中展示了五种 order flow

**[A] Traditional**  
下单给 sell-side, sell-side 可以跟自己的inventory交易，也可以拿到市场上去交易。

**[B][E] DMA**  
Buy-side通过broker的基础系统，直接连接到交易所并下单。  
更有甚者，buy-side可以得到sponsored access直接连接到交易所（往往是出于高频交易的需要）

**[C][D] Algorithm Trading**   
通过预算设定好的算法来做Execution，甚至也可以归类到是Buy-side DMA


另外，图中buy-side内部分工也可以关注一下。

很无奈的是，这种交易流水线已经让trader变成了executor，与其说算法交易，不如说algorithmic execution。

## Trading Algorithms
![Algorithms](/img/in-post/[AlgoTrading]AlgoTable.png)

一开始就是TWAP和VWAP，后来通过不断地TCA，逐渐进化出了 Implementation Shortfall (IS)  
> These new algorithms tried to tackle what Robert Kissell and Morton Glantz (2003)  termed the trader's dilemma: **trading too fast brings high market impact costs whilst  trading too slowly exposes us to considerable risk**.

第三代的算法源自Liquidity。
很多第一代算法只关注 best bid-ask quotes，后来由于交易场所的增多、以及orderbook显示的更多，捕捉流动性的算法也变得重要起来。
通常通过 order routing system 来做，有时候routing到dark-pool也有。

## Trading Method Comparison
![Comparison](/img/in-post/[AlgoTrading]MethodComparison.png)

在效率上，算法交易非常有优势。  
在实用性上，DMA有更多的掌控权和透明度，而Crossing有最强的匿名性。  
另外，算法交易所需要的市场知识比较少。

## Fears and Myths
> It is important to remember that algorithmic trading is just a tool, not a panacea. It is not designed to generate profits (or alpha), simply to  help control costs and provide best execution

### Safety of algorithmic trading 
+ [x] Algorithms are fundamentally changing the market
+ [ ] Algorithms will replace traders
+ [ ] Algorithms can leak alpha to proprietary traders 
### Usefulness  of algorithmic trading
+ [ ] Algorithms arc complicated to use 
+ [ ] They only really work for liquid assets or small orders

# [Chapter 2] Market microstructure
## Transaction cost measurement and analysis
### Using Spreads
1. Quoted Spread  
   市场bid-ask。用来衡量市场情况。
2. Effective Spread   
   实际交易价格与**刚收到订单时的bid-ask中值**的差。用来衡量订单执行(Execution)。
3. Realized Spread  
   实际交易价格与**收到订单5min后的bid-ask中值**的差。用来衡量交易中间利润(Intermediary profits)。
### Using Benchmarks
1. Post-trade
   - Close
   - Future close
2. Intraday
   - Open-High-Low-Close(OHLC)的平均值
   - TWAP
   - VWAP
3. Pre-trade
   - Previous close
   - Opening price
   - Decision price
   - Arrival price

### Components of transaction costs
按照Visibility排序：

1. Commissions, Fees, and Taxes
2. Spread Cost
3. Delay Cost
4. Market Impact
5. Timing Cost  
6. Opportunity Cost

# [Chapter 3] World Markets 
## Asset Classes
- Equity
- Fixed Income
- Foreign Exchange (FX): including FX swaps
- Money Markets: including REPO, securities lending
- Derivatives
  - Futures and options
  - Swaps
  - Credit derivatives: including CDS (Credit Default Swaps)

## Market Structure
### Average Daily Turnover
![AverageDailyTurnover](/img/in-post/[AlgoTrading]AveDailyTurnover.png)
最多的居然是 exchange traded (ET) derivatives




-------------------------------------------

# [Chapter 4] Orders
> Orders are the fundamental building block for any trading strategy.

## Order Types
- Market Order
  - depend on current market conditions (liquidity)
  - speed and certainty of execution
- Limit Order
  - lack of execution certainty
  - has potential to gain from future trend
- Market-to-limit orders
  - 最优五档成交剩余转限价
- Stop Orders
  - 当市场价格超出一定范围，止损单（也可以是止盈单）开始变为活跃的市价单
  - Stop limit order: 触发后变为限价单
  - Trailing stop orders: 当价格变化处于有利方向时，按兵不动；从最高点回落n%时，触发止损单
- Hidden Orders
  - 完全隐藏：可以用IOC订单来尝试cross
  - Iceberg/reserve orders: 像冰山一样，部分可见（书中有完整示例）
- Discretional orders
  - Not-held order：交易员完全自主的选择权
  - Discretionary orders：有一个
- Pegged orders
  - 动态的限价单，紧盯盘口
  - 还可以增加最小交易量限制，防止价格被小单子打上去
- 
- 

## Order Options
### Duration
- good for the day (GFD) 
- good til date (GTD)
- good tile cancel (GTC)
- good after time (GAT)

### Auction session instructions
集合竞价的指令，一般是为了最大化订单完成率
- market on open (MOO): 开盘集合竞价，若未成交则转限价或取消
- market on close (MOC)
- limit on close (LOC): 收盘限价单，限制交易价格or只有满足一定数量才交易

### Fill instructions
- Immediate or cancel (IOC): 允许部分成交，不管结果如何马上cancel
- Fill or kill (FOK): 如果没有立刻成交全部，就马上cancel
- All or none (AON): 如果**当天**没有全部成交的机会，就cancel  
  *这种单一般是low priority*
- Minimum volume / Minimum fill: 例如有AON order存在，使得有些单子有最小成交限制。
- Must be filled: 一般是期货期权的平仓换仓
- Flashing: 短暂的挂单后，马上撤单
- One-cancels-other (OCO)
- One-triggers-other (OTO) 

# [Chapter 5] Algorithm Overview
## Category
![Algo Category](/img/in-post/[AlgoTrading]AlgoCategory.png)
- Impact-driven：尽量减少市场冲击
- Cost-driven：尽量降低总的交易成本
- Opportunistic algo：抓住一切有利的交易条件

## TWAP
TWAP内容很简单，但是有一些变种。
![TWAP Rate](/img/in-post/[AlgoTrading]TWAPCompletionRate.png)
Aggressive一开始做得快一些。

## VWAP
Given $n$ trades in a day, each with a specific price $P_n$ and size $v_n$
$$
\mathrm{VWAP} = \frac{\sum_n{v_nP_n}}{\sum_n{v_n}}
$$
但是预先不知道每天的实际交易情况，所以要进行估计。一般是拿历史数据计算每个时间段$j$的交易比例$v_j$，这样交易得到的VWAP价格为
$$
\mathrm{VWAP} = \sum_j{v_j\bar{P_j}}
$$
每个时间段的实际交易量目标是$x_j=v_jX$，其中$X$是总的订单量。

> **Trending/Tilting**
> 如果预计到一天内有趋势，那就可以将VWAP的分配适当向开始/结尾时间段倾斜

## Percent of Volume (POV)
> *AKA.* volume  inline, participation, target  volume or  follow algorithms  

保持对市场成交量的跟踪，一般是20%左右，什么时候做完了就结束。






