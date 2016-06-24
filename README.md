# Investing Returns on the S&P500

Source file `stocks.csv` last updated on 2016-06-24.

### Table of Contents

* [About](https://github.com/zonination/investing/blob/master/README.md#about)
* [Gallery](https://github.com/zonination/investing/blob/master/README.md#gallery)
* [Exploration and Explanations](https://github.com/zonination/investing/blob/master/README.md#exploration-and-explanations)
* [Other Visualizations](https://github.com/zonination/investing/blob/master/README.md#other-visualizations)

## About

A lot of you know me from my comments and posts on Reddit's /r/personalfinance. I have also recently been spending a lot of time at /r/dataisbeautiful as well. This started off as my first dataviz project a while back. I downloaded [some data based on Robert Shiller's work](https://github.com/datasets/s-and-p-500/tree/master/data) and went crazy with it. Now that I've finally settled in and gotten other projects completed, I picked this one back up and decided to finally drive it to completion.

> "Warren, it strikes me that if you did nothing else you never sell. That is, if you can grit your teeth through and just disregard short-term declines in the market or even long-term declines in the market, you will come out well. I mean you just stick all your money in stocks and go home and don’t look at your portfolio you’ll do far better than if you try to trade it." - Alan Greenspan

A lot of people on /r/personalfinance, usually green to the wonders of long-term investing, often question the security of the "buy and hold" strategy, or would rather try to time the market instead. This viz project is an attempt to do three things:

1. Objectively explore past returns, so that all facets of long-term investing (past and present) are explored.
2. Show--with figures--how market timing, panic selling, and active day trading are probably futile strategies.
3. Show that the "Invest Early and Invest Often" adage holds weight, and how much.

## Gallery


Final Plot:  
![Investing Returns](https://raw.githubusercontent.com/zonination/investing/master/returns.png)

Final Plot with Average markings:  
![Investing Returns (marked with an average)](https://raw.githubusercontent.com/zonination/investing/master/returns-average.png)

## Exploration and Explanations

The plots above were generated based on past returns in the S&P500. So at Year 1, we take every point on the S&P500 curve, look at every point on the S&P500 that's one year ahead, add in dividends and subtract inflation, and record all points as a relative gain or loss for Year 1. Then we do the same thing for Year 2. Then Year 3. And so on, ad nauseum. The program took a couple hours to finish crunching all the numbers.

In short, for the plots above: **If you invest for X years, you have a distribution of Y possible returns,** based on previous history.

I can already hear the keyboards being tapped for the comments section: "Wait, Zoni! this is over the span of 145 years! Nobody is ever going to live to invest for that long." I know, so let's take a look at a more realistic span of investing. Let's say you start investing at the age of 20, and then retire at age 60, which gives you 40 years of investing. Here's what that snapshot will look like:

![Investing for 40 years](https://raw.githubusercontent.com/zonination/investing/master/returns-40yr.png)

Wait a minute. Zoom in. What's going on with those data points that are losing money over X years?

![What?](https://raw.githubusercontent.com/zonination/investing/master/returns-40yr-lowbox.png)

Keep in mind that this is a *distribution* of returns. After 1 year of investing, you might sell high or you might sell low. After 20 years, you're almost guaranteed to sell high. By 40 years, you're turning a major profit.

![Probability of selling short](https://raw.githubusercontent.com/zonination/investing/master/short-probability.png)

Some of the worst market downturns are also represented here, like the [Great Depression](https://en.wikipedia.org/wiki/Great_Depression), the [1970s recession](https://en.wikipedia.org/wiki/1973%E2%80%9374_stock_market_crash), [Black Monday](https://en.wikipedia.org/wiki/Black_Monday_(1987)), the [Dot-Com Bubble](https://en.wikipedia.org/wiki/Dot-com_bubble), the [2008 Financial Crisis](https://en.wikipedia.org/wiki/Financial_crisis_of_2007%E2%80%9308). But note how they completely recover to turn a profit after some more time in the market.

Here's the list of years you can invest, and still be down after:

* **Still down after 10 years:** [[share a list]]
* **Still down after 15 years:** [[share a list]]
* **Still down after 20 years:** [[share a list]]
* **Still down after 25 years:** [[none (?)]]

But that doesn't consider all the years that were average, or even the years that were extremely profitable for investors.

![Look at all this money](https://raw.githubusercontent.com/zonination/investing/master/returns-40yr-box.png)

Long story short, buy and hold. Invest for the long-term, and not the short term. Don't try to time the market; [even if you invested at market peaks, you'd still make out well](http://awealthofcommonsense.com/2014/02/worlds-worst-market-timer/).

![Do I invest here or here?]()

![Does it matter?]()

## Other Visualizations
