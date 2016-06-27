# Investing Returns on the S&P500

Source file `stocks.csv` last updated on 2016-06-24.

### Table of Contents

* [Disclaimer](https://github.com/zonination/investing/blob/master/README.md#disclaimer)
* [About](https://github.com/zonination/investing/blob/master/README.md#about)
* [Gallery](https://github.com/zonination/investing/blob/master/README.md#gallery)
* [Exploration and Explanations](https://github.com/zonination/investing/blob/master/README.md#exploration-and-explanations)
* [Frequently Asked Questions](https://github.com/zonination/investing/blob/master/README.md#frequently-asked-questions)
* [Other Visualizations](https://github.com/zonination/investing/blob/master/README.md#other-visualizations)
* [Sources](https://github.com/zonination/investing/blob/master/README.md#sources)
* [Further Reading](https://github.com/zonination/investing/blob/master/README.md#further-reading)

## Disclaimer

Note that this stock market simulation assumes a portfolio that is invested in 100% US Stocks. While a lot of the results show that 100% Stocks can generate an impressive return, **this is not an ideal portfolio.**

**A portfolio should be diversified** with a good mix of US Stocks, International Stocks, and Bonds. This diversification helps to hedge against market swings, and will help the investor to optimize returns on their investment with lower risk than this visual demonstrates.

If you are interested in reviewing your asset allocation or auditing your portfolio, check out the [Further Reading](https://github.com/zonination/investing/blob/master/README.md#further-reading) section below.

## About

A lot of you know me from my comments and posts on Reddit's /r/personalfinance. I have also recently been spending a lot of time at /r/dataisbeautiful as well. This started off as my first dataviz project a while back. I downloaded [some data based on Robert Shiller's work](https://github.com/datasets/s-and-p-500/tree/master/data) and went crazy with it. Now that I've finally settled in and gotten other projects completed, I picked this one back up and decided to finally drive it to completion.

> "Warren [Buffet], it strikes me that if you did nothing else you never sell. That is, if you can grit your teeth through and just disregard short-term declines in the market or even long-term declines in the market, you will come out well. I mean you just stick all your money in stocks and go home and don’t look at your portfolio you’ll do far better than if you try to trade it." - Alan Greenspan

A lot of people on /r/personalfinance, usually green to the wonders of long-term investing, often question the security of the "buy and hold" strategy, or would rather try to time the market instead. This viz project is an attempt to do three things:

1. Objectively explore past returns, so that all facets of long-term investing (past and present) are explored.
2. Show that the "Invest Early and Invest Often" adage holds weight, and by how much.
3. Observe what happens when a "buy and hold" strategy is implemented, and how well that performs.

## Gallery


Final Plot:  
![Investing Returns](https://raw.githubusercontent.com/zonination/investing/master/returns.png)

Final Plot with Average markings:  
![Investing Returns (marked with an average)](https://raw.githubusercontent.com/zonination/investing/master/returns-average.png)

## Exploration and Explanations

The plots above were generated based on past returns in the S&P500. So at Year 1, we take every point on the S&P500 curve, look at every point on the S&P500 that's one year ahead, add in dividends and subtract inflation, and record all points as a relative gain or loss for Year 1. Then we do the same thing for Year 2. Then Year 3. And so on, ad nauseum. The program took a couple hours to finish crunching all the numbers.

In short, for the plots above: **If you invest for X years, you have a distribution of Y possible returns,** based on previous history.

I can already hear the keyboards being tapped for the comments section: "Wait, Zoni! this is over the span of 145 years! Nobody is ever going to live to invest for that long." I know, so let's take a look at a more realistic span of investing. Let's say you start investing at the age of 20, and then retire at age 60, which gives you 40 years of investing. So after a quick `subset(stocks,year<=40)`. Here's what that snapshot will look like:

![Investing for 40 years](https://raw.githubusercontent.com/zonination/investing/master/snippets/returns-40yr.png)

Wait a minute. Zoom in. What's going on with those data points that are losing money over X years?

Keep in mind that this is a *distribution* of returns. After 1 year of investing, you might sell high or you might sell low. After 20 years, you're almost guaranteed to sell high. By 40 years, you're turning a major profit. [Code provided here](https://github.com/zonination/investing/blob/master/snippets/snip1.R)

![Probability of selling short](https://raw.githubusercontent.com/zonination/investing/master/snippets/short-probability.png)

Some of the worst market downturns are also represented here, like the [Great Depression](https://en.wikipedia.org/wiki/Great_Depression), the [1970s recession](https://en.wikipedia.org/wiki/1973%E2%80%9374_stock_market_crash), [Black Monday](https://en.wikipedia.org/wiki/Black_Monday_(1987)), the [Dot-Com Bubble](https://en.wikipedia.org/wiki/Dot-com_bubble), the [2008 Financial Crisis](https://en.wikipedia.org/wiki/Financial_crisis_of_2007%E2%80%9308). But note how they completely recover to turn a profit after some more time in the market.

Here's the list of years you can invest, and still be down. Take note that **some of these years cover the same eras**:

* **Down after 10 years** (11.8% chance historically)**:** 1908 1909 1910 1911 1912 1929 1930 1936 1937 1964 1965 1966 1967 1968 1969 1970 1971 1973 1973 1998 1999 2000 2001
* **Down after 15 years** (4.73% chance historically)**:** 1905 1906 1907 1929 1964 1965 1966 1967 1968 1969
* **Down after 20 years** (0.0664% chance historically)**:** 1901
* **Down after 25 years** (0% chance historically)**:** *none*

(code :`unique(subset(stocks,multip<1&year==20)$inv.year)`)

But that doesn't consider all the years that were average, or even the years that were extremely profitable for investors.

Long story short, buy and hold. Invest for the long-term, and not the short term. Don't try to time the market; [even if you invested at market peaks, you'd still make out well](http://awealthofcommonsense.com/2014/02/worlds-worst-market-timer/).

## Frequently Asked Questions

## Other Visualizations

This viz actually started off as an animation. Below is the original plot for the animation:

![Animation: Growth of Stock Market](https://raw.githubusercontent.com/zonination/investing/master/altplots/growth.gif

I'll step through a few freeze-frames of the plot above:

![Animation: Growth of Stock Market - 10 years](https://raw.githubusercontent.com/zonination/investing/master/altplots/growth-10.png)

![Animation: Growth of Stock Market - 20 years](https://raw.githubusercontent.com/zonination/investing/master/altplots/growth-20.png)

![Animation: Growth of Stock Market - 30 years](https://raw.githubusercontent.com/zonination/investing/master/altplots/growth-30.png)

![Animation: Growth of Stock Market - 40 years](https://raw.githubusercontent.com/zonination/investing/master/altplots/growth-40.png)

The code for these plots is shared in the `altplots` folder.

## Sources

## Further Reading

* [Personalfinance Wiki on Investing](https://www.reddit.com/r/personalfinance/wiki/investing)
* [I have $X. What do I do with it?](https://www.reddit.com/r/personalfinance/wiki/commontopics)
* [The Bogleheads Wiki on Three Fund Portfolios](https://www.bogleheads.org/wiki/Three-fund_portfolio)
