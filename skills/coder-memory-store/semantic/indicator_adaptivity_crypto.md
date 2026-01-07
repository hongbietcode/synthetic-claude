**Title:** Indicator Adaptivity Determines Crypto Strategy Success

**Description:** Adaptive indicators (BB, ATR, Keltner) outperform static indicators (IBS, fixed thresholds) in high-volatility crypto markets. Sprint 14 BB achieved 31.61% robust rate vs Sprint 17 IBS 0% on identical data.

**Content:**

### Critical Discovery: Single-Candle vs Multi-Period Adaptivity

Designed and tested two mean-reversion strategies on identical 2023-2024 BTCUSDT data:
- **Sprint 14: Bollinger Bands + RSI** - 31.61% robust rate ✅
- **Sprint 17: Internal Bar Strength (IBS)** - -$4.21 PNL, 0% profitable ❌

**Root Cause**: Adaptive vs static threshold calculation

**Sprint 14 Success Mechanism**:
- Bollinger Bands: 20-period rolling std dev (adapts to current volatility)
- Entry: Close ≤ BB_lower (2 std devs from SMA-20) + RSI < 30
- Signal quality: Bands expand/contract based on market regime
- Result: 31.61% of solutions profitable across 2023 + 2024-2025

**Sprint 17 Failure Mechanism**:
- IBS formula: (Close - Low) / (High - Low) [single candle only]
- Entry: IBS < 0.12 (static threshold, no market context)
- Signal quality: What's "extreme panic" in SPY is normal Tuesday in BTC
- Result: -$4.21 median PNL, all 16 Pareto solutions unprofitable

**Empirical Evidence**:
```
BTCUSDT 2023-2024 IBS Analysis:
- IBS < 0.12 frequency: 9.62% of time (1,687 / 17,544 candles)
- With SMA-200 filter: 780 trades/year
- Problem: Static threshold doesn't distinguish volatility regimes
```

**The Universal Pattern**:

1. **Adaptive indicators** calculate thresholds from recent market data
   - Bollinger Bands (std dev from rolling mean)
   - ATR (average true range)
   - Keltner Channels (ATR-based bands)

2. **Static indicators** use universal thresholds
   - IBS (fixed 0.12/0.88 levels)
   - Fixed price levels
   - Static RSI thresholds without context

3. **Asset class matters**:
   - High-volatility crypto: Adaptive >> Static
   - Low-volatility equities: Both work (SPY IBS Sharpe 1.8 in research)

**Application Guidelines**:

✅ **Use for crypto**:
- Bollinger Bands (adapts to volatility)
- ATR-based stops/filters
- Keltner Channels
- RSI WITH BB confirmation (RSI static, but BB provides adaptive context)

❌ **Avoid for crypto**:
- IBS (Internal Bar Strength)
- Fixed price levels
- Static percentage thresholds
- Direct equity strategy ports without validation

**Critical Lesson**: Don't assume equity research (SPY, QQQ) transfers to crypto without empirical validation. What's "extreme" in equities may be normal in crypto.

**Evidence Base**:
- Sprint 14: BB mean-reversion 31.61% robust on 2023-2024 (empirical proof)
- Sprint 17: IBS mean-reversion -$4.21 PNL on identical data (empirical failure)
- Parameter convergence: All 16 IBS Pareto solutions at boundaries (0.12/0.90) = strategy exhausted, not parameter issue

**Confidence Level**: VERY HIGH (proven by back-to-back tests on identical data, identical timeframe, different indicator types)

**Tags:** #strategy-design #indicators #crypto #volatility #adaptivity #success #failure #mean-reversion #bollinger-bands #ibs #quant

**Memory Type:** semantic (universal principle for crypto strategy design)

**Frequency:** High-value lesson applicable to all future crypto strategy development

**Role Collection:** quant

**Created:** 2025-11-29
**Sprint Context:** Sprint 14 (BB success) vs Sprint 17 (IBS failure)
**Data Period:** 2023-2024 BTCUSDT identical comparison
