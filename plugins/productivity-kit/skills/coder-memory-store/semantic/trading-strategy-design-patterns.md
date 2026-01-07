# Trading Strategy Design Patterns

Lessons from Sprint 11/12/13 strategy development failures and successes. These patterns apply to quantitative trading, especially crypto with high volatility.

---

**Title:** Regime Filter Paradox - Volatility Filters Remove the Opportunities They're Supposed to Protect
**Description:** Mean-reversion strategies need volatility to create entry signals, but volatility regime filters prevent those signals from occurring.

**Content:** Mean-reversion strategies (RSI, Bollinger Bands, ADX) generate entry signals DURING volatility spikes—oversold conditions occur when price swings significantly. However, regime filters designed to trade "safely" (ADX < 25 for ranging markets, BB_width < 0.06 for low volatility) explicitly remove volatility spikes. Sprint 11 & 12 failed catastrophically: RSI < 30 AND ADX < 25 = <0.5% signals (#failure), RSI < 30 AND BB_width < 0.06 = <0.5% signals (#failure). Root cause: filters removed 80-90% of opportunities. Sprint 13 succeeded by inverting the philosophy: momentum breakout WITH volatility (no regime filters) = 2.00% signals (#success). Universal pattern: any strategy requiring market extremes + volatility filters = paradox = failure. Solution: use regime indicators for EXIT triggers (profit protection), not entry filters. This applies beyond trading: risk-averse entry filters paradoxically increase opportunity cost.

**Tags:** #failure #strategy-design #regime-filters #mean-reversion #crypto #volatility-paradox #universal-antipattern

---

**Title:** Pre-Flight Signal Frequency Check - Validate Entry Opportunity Before Expensive Optimization
**Description:** Always validate that strategy generates sufficient entry signals (>0.5-1% of candles) before running expensive parameter optimization.

**Content:** Running multi-minute optimizations (10-30 min) only to discover <0.5% signal frequency wastes time and computational resources because such restrictive entry logic guarantees poor out-of-sample performance. Sprint 11 wasted 10 minutes on optimization → discovered 0.1% robust rate. Sprint 12 wasted 28 minutes → discovered 0.28% robust rate. Total waste: 38+ minutes across 2 sprints. Pattern: create minimal datapoints test (20-100 candles) as FIRST progressive step with signal frequency analysis BEFORE full optimization. Implementation: count entry signals as percentage of total valid candles, abort if <0.5%, refine logic if necessary. Sprint 13: 1 minute datapoints test caught 2.00% frequency BEFORE optimization, avoided 10+ minutes waste. Cost: 1 minute per strategy vs benefit: save 10+ minutes if strategy was too restrictive. Workflow: (1) Implement strategy logic, (2) Run datapoints test with frequency counter, (3) If frequency < 0.5%, refine before full optimization.

**Tags:** #procedural #testing #validation #pre-flight-check #progressive-testing #optimization #workflow

---

**Title:** Triple-AND Logic Kills Crypto Opportunities - Use Maximum 2 Conditions for Entry
**Description:** Each AND condition multiplies restriction rate exponentially; cryptomarkets with 3+ conditions yield <0.5% opportunities.

**Content:** In high-volatility markets, probability of multiple independent conditions occurring simultaneously decreases exponentially: 10% × 20% × 25% = 0.5% (if independent). Sprint 11: 3 conditions (RSI + ADX + Bollinger Band) = <0.5% signals (#failure). Sprint 12: 3 conditions (RSI + BB_width + BB band) = <0.5% signals (#failure). Sprint 13: 2 conditions (Breakout + Volume) = 2.00% signals (#success). Rule for crypto: use 2 conditions MAX for entry logic. Exception: if 3+ conditions necessary, use OR logic for some pairs: `(A AND B) OR (C AND D)` instead of `A AND B AND C AND D`. This compounds restrictiveness less severely. Academic support: complex entry filters are the primary cause of strategy failure in backtests vs live trading. Pattern applies broadly: each authentication requirement (2FA, email verify, phone verify) reduces signup by 5-20% exponentially, creating funnel disasters.

**Tags:** #semantic #strategy-design #entry-logic #crypto #volatility #signal-frequency #design-pattern

---

**Title:** Volume Confirmation Without Opportunity Loss - Goldilocks Filter Pattern
**Description:** Volume filters (1.5-2.0× average) confirm genuine moves without removing entire market regimes like traditional regime filters.

**Content:** Volume surge acts as a "Goldilocks" filter: strong enough to reduce noise, weak enough to appear 5-10% of candles (vs 30-80% regime filters), spans both trending and ranging markets. Why it works: institutional participation creates volume spikes regardless of trend direction; ADX/BB regime filters explicitly remove market conditions. Evidence: ADX < 25 filters 70-80% of time (removes regimes), BB_width < 0.06 filters 70-80% (removes regimes), volume > 1.5× filters 50-60% (removes noise, not regimes). Academic support: Granville (1963) "Volume precedes price" - volume surge precedes directional moves. Implementation pattern: `(primary_condition) AND (volume > 1.5 * avg_volume_20)` retains signal opportunities across all market conditions. Failed approach: regime filters that remove entire market structures. Successful approach: volume filters that require institutional participation confirmation.

**Tags:** #success-pattern #volume-confirmation #filters #strategy-design #signal-confirmation #crypto #academic-support

---

**Title:** Invert Failed Approaches for Alternative Solutions - Philosophical Inversion Strategy
**Description:** When strategy fails repeatedly, test the OPPOSITE philosophical approach before abandoning the category.

**Content:** Meta-pattern: failed strategy + inversion = potential solution. Sprint 11/12 failed approach: "Filter OUT volatility to trade mean-reversion safely" → result: 0.1-0.28% robust rate (too restrictive). Sprint 13 inverted approach: "Trade WITH volatility via momentum breakouts" → result: 2.00% signal frequency (viable for progression). The inversion wasn't random—it addressed the root cause (regime filters were the problem) by embracing volatility instead of fighting it. Pattern applies universally: if mean-reversion + volatility filters fail, try momentum + volatility embrace. If long-only trending fails, try range-trading within trends. If technical analysis fails, try volume profile. Workflow when stuck: (1) Identify philosophical assumption of failed approach, (2) Invert it, (3) Test inversion on small scale, (4) If promising, proceed with full progression. This prevents abandoning entire strategy categories after one failure mode, often yielding viable alternatives.

**Tags:** #semantic #meta-pattern #problem-solving #strategy-design #inversion-technique #success

---

**Title:** Signal Frequency Targets for Crypto Trading Strategies
**Description:** Empirically-derived minimum signal frequency thresholds below which strategies fail regardless of parameter optimization.

**Content:** Based on Sprint 11/12/13 results, signal frequency targets for crypto: <0.5% entry signals = strategy too restrictive, optimization will fail (tested up to 28 min of optimization yielded 0.1-0.28% robust rates). 0.5-1.0% = marginal, likely viable but suboptimal. 1.0-5.0% = good range, viable for multiple parameter solutions. 2.0% observed as practical sweet spot (Sprint 13 momentum breakout). >10% = potentially too broad, risk of overfitting. These targets assume 1-minute candle data over 3+ years (roughly 1.5M candles). For different timeframes: 4-hour candles would have 256× fewer samples, proportionally stricter targets; 15-second candles would have 4× more samples, relaxed targets. Workflow: (1) Calculate signal frequency on datapoints test, (2) If outside 0.5-5% range, refine logic, (3) Test frequency again, (4) Proceed to full optimization only after frequency check passes. This prevents running expensive optimizations on strategies with insufficient opportunity density.

**Tags:** #semantic #signal-frequency #crypto #empirical-thresholds #optimization #validation-pattern

---

**Title:** Regime-Appropriate Training Data Selection for Mean-Reversion Strategies
**Description:** Mean-reversion strategies must be trained on regime-appropriate data (ranging/choppy markets), not simply the longest available historical period.

**Content:** Traditional ML assumes "more data = better," but trading strategies exhibit negative transfer learning when trained on mismatched market regimes. Mean-reversion strategies profit in ranging/choppy markets but suffer catastrophic losses in sustained trends. Sprint 14 empirical evidence: (1) Initial test on 2020-2022 (included 2021 bull run) → ALL strategies showed -inf PNL on trending periods (#failure), (2) Re-tested on 2023-2024 ranging regime → 31.61% robust rate (#success). Same strategy, different training regime = opposite results. Root cause: training on 2020-2021 bull run teaches mean-reversion to "fade rallies" (correct for ranging) but this becomes catastrophic in actual bull markets. Training on 2023-2024 ranging teaches "buy dips, sell rips" which works in choppy markets. Academic support: hedge strategy research identifies regime shift as catastrophic risk for mean-reversion; pairs trading literature documents cointegration breaks during regime changes. Implementation pattern: (1) Identify strategy regime dependency (mean-reversion → ranging, momentum → trending, market-neutral → regime-agnostic), (2) Analyze market regime of available training periods (trending vs ranging via ADX, volatility, trending strength), (3) Select training period matching strategy type (2023-2024 crypto = ranging, ideal for mean-reversion), (4) OOS validate on DIFFERENT regimes (2022 bear, 2025 current) to quantify regime sensitivity, (5) Set realistic expectations (Sharpe 1.5 in-regime, 0.5 out-of-regime is EXPECTED, not failure). Anti-pattern: "Let's use 2020-2022 because it's 3 years of data" without regime analysis. Mean-reversion trained on trending data learns wrong lessons. Expecting consistent performance across all regimes (unrealistic). Correct workflow: Match training regime to strategy type, test OOS on different regimes for graceful degradation, accept lower performance out-of-regime. This applies beyond crypto: any regime-dependent strategy (statistical arbitrage, carry trades, volatility harvesting) requires regime-matched training data.

**Tags:** #semantic #regime-awareness #training-data #mean-reversion #strategy-design #failure-prevention #regime-shift #transfer-learning #quant

---
