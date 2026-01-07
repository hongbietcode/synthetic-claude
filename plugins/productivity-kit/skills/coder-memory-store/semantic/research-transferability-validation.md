# Research Transferability Validation Patterns

Lessons about validating research findings before transferring strategies from one market regime to another with different volatility characteristics.

---

**Title:** Cross-Market Research Transferability Requires Semantic Validation
**Description:** Research findings from one market regime don't automatically transfer to different volatility regimes. Indicator signals must have equivalent semantic meaning in both contexts.

**Content:**

When implementing trading strategies based on published research, the assumption that "if it works on Market A, it should work on Market B" often fails catastrophically due to differences in volatility characteristics and signal semantics.

**Case Study: IBS Mean-Reversion Strategy (Sprint 17)**

**Research Background:**
- Strategy: Internal Bar Strength (IBS) mean-reversion
- Source market: SPY (S&P 500 index) 1993-2024
- Research results: Sharpe 1.8, 68% win rate, CAGR 12.5%
- Research basis: Quantified Strategies (well-documented academic approach)
- Entry logic: Buy when IBS < 0.20 (extreme oversold)

**Implementation Results:**
- Target market: BTCUSDT (crypto) 2023-2024
- Result: Median PNL -$4.21 (100% negative), MaxDD 28.39%
- Trade frequency: 780/year (5× higher than expected based on SPY research)
- Parameter convergence: All 16 Pareto solutions converged to extreme thresholds (IBS < 0.12 / > 0.9)
- Robust rate: 0% (complete failure)

**Root Cause Analysis (QR 95% Confidence):**

The semantic meaning of IBS thresholds differs fundamentally between equity and crypto markets:

**SPY (Equity Index):**
- IBS < 0.20 occurs rarely (true panic events)
- Represents genuine institutional selling pressure
- Typically mean-reverts within 1-3 days
- Low volatility baseline (VIX average ~15-20)

**BTCUSDT (Crypto):**
- IBS < 0.12 occurs 9.62% of time (1,687/17,544 candles - normal volatility pattern)
- Represents routine intraday oscillations, not panic
- May continue trending for days without reversion
- High volatility baseline (crypto VIX equivalent 60-100+)

**The Fundamental Problem:**

What constitutes an "extreme" signal in low-volatility equities is routine noise in high-volatility crypto. The IBS threshold values (0.20, 0.80) were calibrated to SPY's volatility regime and have no transferable semantic meaning in crypto's regime.

**Contrasting Evidence:**

**Failed Transferability (Sprint 17):**
- IBS (single-candle static indicator): 0% robust rate
- No volatility adaptation mechanism
- Fixed thresholds lose semantic meaning across regimes
- 780 trades/year = signal abundance without quality

**Successful Cross-Market Strategy (Sprint 14):**
- Bollinger Bands (20-period adaptive indicator): 31.61% robust rate
- Same BTCUSDT 2023-2024 data
- Adapts to local volatility via rolling standard deviation
- Context-aware signals maintain semantic meaning

**Universal Pattern:**

Research findings transfer successfully when:

1. **Indicator Type Alignment:**
   - ✅ Adaptive/multi-period indicators (BB, ATR, Keltner) → Transfer well
   - ❌ Static/single-candle indicators (IBS, fixed RSI thresholds) → Transfer poorly

2. **Semantic Validation Required:**
   - What does IBS < 0.20 MEAN in SPY? (Rare panic, 1-2% occurrence)
   - What does IBS < 0.20 MEAN in BTCUSDT? (Common noise, 15-20% occurrence)
   - If meanings diverge → Recalibrate or reject strategy

3. **Volatility Regime Analysis:**
   - Source market baseline volatility (SPY VIX ~15-20)
   - Target market baseline volatility (BTCUSDT VIX equivalent 60-100+)
   - If >3× difference → High risk of semantic divergence

4. **Progressive Testing Catches Issues Early:**
   - Sprint 17 progressive testing (Phase 1-2) caught failure before full optimization
   - Cost: 15 minutes datapoints + 1-coin test
   - Saved: 2+ hours full optimization + validation on failed strategy

**The Anti-Pattern (What We Did Wrong):**

1. ✅ Found published research (SPY IBS: Sharpe 1.8, 68% win rate)
2. ❌ **ASSUMED research transfers to different market** (crypto)
3. ❌ **Designed full 11,500-word strategy spec** without validation
4. ❌ **Only discovered failure during implementation/testing** (Phase 2)
5. ❌ Result: 4.5 hours wasted on invalid research assumption

**The Correct Pattern (How to Prevent):**

1. ✅ Find published research (SPY IBS: Sharpe 1.8, 68% win rate)
2. ✅ **VALIDATE market characteristics match FIRST**:
   - Asset type: Index vs single asset?
   - Volatility regime: Low-vol equities vs high-vol crypto?
   - Market hours: 6.5h/day vs 24/7?
   - Signal semantics: What does IBS < 0.12 MEAN in each market?
3. ✅ **Run quick data analysis BEFORE full spec** (5 minutes):
   - Calculate IBS distribution on target market
   - Check if "extreme" thresholds are actually extreme
   - Compare signal frequency to research baseline
4. ✅ **If mismatch detected**: Either adapt thresholds OR reject strategy
5. ✅ **Only write full spec after validation**
6. ✅ Result: 5 minutes saves 4.5 hours (54× ROI)

**Quick Validation Script Example:**

```python
# BEFORE writing 11,500-word spec, run this (5 minutes):
import numpy as np
from data import get_ohlcv

data = get_ohlcv('BTCUSDT', '2023-2024', '1h')
ibs = (data.close - data.low) / (data.high - data.low)

print(f"IBS < 0.12 frequency: {np.sum(ibs < 0.12) / len(ibs) * 100:.2f}%")
print(f"SPY research: IBS < 0.12 is RARE")
print(f"If BTC frequency > 5%: REJECT strategy (threshold not extreme)")

# Sprint 17 output: 9.62% → 20× more frequent than SPY → REJECT
```

**Decision Framework for Cross-Market Research:**

**Before implementing research from Market A on Market B:**

1. **Classify Indicator Type:**
   - Static threshold (IBS, fixed RSI levels): HIGH RISK
   - Adaptive/multi-period (BB, ATR, adaptive RSI): MEDIUM RISK
   - Regime-agnostic (volume, price action patterns): LOW RISK

2. **Compare Volatility Regimes:**
   - Calculate baseline volatility ratio (target/source)
   - If ratio > 3×: MANDATORY semantic validation
   - If ratio < 2×: Standard validation sufficient

3. **Semantic Validation Test:**
   - Calculate signal frequency in BOTH markets
   - SPY: IBS < 0.20 = 1-2% occurrence (rare)
   - BTCUSDT: IBS < 0.12 = 9.62% occurrence (common)
   - If frequency diverges >3×: Signals have different meanings

4. **Recalibration or Rejection:**
   - If semantic divergence detected: Recalibrate thresholds to match frequency
   - If recalibration impossible (fundamental regime mismatch): Reject strategy
   - If semantic alignment confirmed: Proceed with progressive testing

5. **Progressive Testing Protocol:**
   - Phase 1: Datapoints test (signal frequency analysis)
   - Phase 2: 1-coin test (PNL validation on small sample)
   - If Phase 1-2 fail: Stop before expensive optimization
   - If Phase 1-2 pass: Proceed to full implementation

**Red Flags for Transfer Risk:**

- Research uses fixed thresholds calibrated to specific market
- Source and target markets have >3× volatility difference
- Indicator is single-period/static (no adaptation mechanism)
- Research doesn't explain WHY strategy works (mechanical fit vs causal logic)
- Signal frequency differs >3× between source and target markets

**Applicable Beyond Trading:**

This pattern applies to any domain where research findings transfer across contexts:

- **Machine learning**: Model trained on ImageNet (1000 classes) → specialized domain (medical imaging 10 classes)
- **A/B testing**: Conversion optimization on desktop (high engagement) → mobile (low engagement)
- **Marketing**: Campaign successful in US market (high purchasing power) → emerging market (low purchasing power)
- **Performance optimization**: Database tuning for read-heavy workload → write-heavy workload
- **Medical research**: Treatment effective in controlled clinical trial → real-world heterogeneous population

**Key Insight:**

When transferring research findings across contexts with different baseline characteristics (volatility, engagement, purchasing power, workload patterns), you must validate that indicator signals/metrics maintain equivalent SEMANTIC MEANING, not just equivalent mathematical values. A threshold of "IBS < 0.20" is a number, but its meaning (panic vs noise) depends entirely on the volatility regime. Progressive testing on small samples (15-30 minutes) catches semantic mismatches before expensive full-scale implementation (2+ hours).

**Time/Cost Analysis:**

**Sprint 17 Actual Costs:**
- Strategy spec writing: 11,500 words (3 hours)
- Implementation + Phase 1-2 testing: 1.5 hours
- **Total waste**: 4.5 hours (detected failure at Phase 2, 16.5 seconds of backtest)
- **Saved**: 5.5 hours (by aborting before full optimization pipeline)

**Prevention ROI:**
- Semantic validation research: 5 minutes (quick data analysis)
- Progressive testing (Phase 1-2): 15-30 minutes
- Full optimization saved (if validation fails): 2-4 hours
- Production debugging saved (if deployed without validation): Days to weeks
- **ROI**: 5-minute validation prevents 4.5 hours wasted work (54× return)

**Tags:** #semantic #research-transferability #volatility-regimes #indicator-semantics #cross-market-validation #failure-prevention #progressive-testing #quant-trading #universal-pattern #roi #adaptive-indicators #static-indicators #regime-awareness

---
