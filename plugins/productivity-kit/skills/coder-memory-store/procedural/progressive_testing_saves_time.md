**Title:** Progressive Testing Workflow for Trading Strategies

**Description:** Test strategies progressively from datapoints → 1 coin → 3 coins → 11 coins → OOS validation. Phase 2 (1-coin test) is the critical gate that saves 5.5 hours by catching fundamental failures early.

**Content:**

### The Progressive Testing Pattern

**Context**: Sprint 17 IBS strategy failed at Phase 2 (16.5 seconds, BTCUSDT only), saving 5.5 hours of wasted computation.

**Traditional Approach** (avoid):
- Implement full 11-coin optimization (2-3 hours)
- Run OOS validation (1 hour)
- THEN discover strategy doesn't work
- **Total waste**: 4+ hours

**Progressive Testing Pattern** (recommended):

**Phase 1: Datapoints Test** (30 min)
- Dataset: ~20 candles only
- Goal: Verify code compiles, Numba JIT works, no syntax errors
- Commit: `Phase 1: Datapoints test passed`

**Phase 2: 1-Coin Test** (45 min) ⚠️ CRITICAL GATE
- Dataset: BTCUSDT 2023-2024 (most liquid, representative)
- NSGA-2: 16×16 or 24×24 (576 evals, not 64×64)
- Goal: Catch fundamental strategy failures
- **RED FLAGS for ABORT**:
  - All Pareto solutions negative PNL
  - Parameter convergence to boundaries
  - Trade frequency too low (<20/year) or too high (>2000/year)
  - Median Sharpe < 0

**Phase 3: 3-Coin Test** (60 min)
- Dataset: BTC, ETH, BNB (diversity test)
- Goal: Verify strategy generalizes across similar assets
- Proceed ONLY if Phase 2 succeeded

**Phase 4: Full 11-Coin Optimization** (90 min)
- Dataset: All available symbols
- NSGA-2: Full 64×64 or 128×128
- Goal: Build complete Pareto front
- Proceed ONLY if Phase 3 succeeded

**Phase 5: OOS Validation** (45 min)
- Datasets: 2022 + 2024-2025 (two separate periods)
- Goal: Calculate robust rate
- Proceed ONLY if Phase 4 succeeded

### Sprint 17 Example (Failure Detection)

**Phase 2 Results** (16.5 seconds):
```
BTCUSDT 2023-2024:
- Pareto solutions: 16
- Median PNL: -$4.21
- Parameter convergence: ALL at 0.12/0.90 boundaries
- Trade frequency: 780/year (abundant signals)
```

**Analysis**:
- Negative PNL despite abundant signals → strategy fundamentally broken
- Boundary convergence → optimizer exhausted search space
- No need to test 3 coins, 11 coins, or OOS

**Decision**: ABORT at Phase 2
**Time saved**: 5.5 hours (avoided Phase 3-5)

### Sprint 14 Example (Success Detection)

**Phase 2 Results**:
```
BTCUSDT 2023-2024:
- Median Sharpe: 1.5-2.0 (positive signal)
- PNL: Positive across Pareto front
- Parameters: Converged to mid-range (not boundaries)
```

**Decision**: PROCEED to Phase 3
**Outcome**: 31.61% robust rate (success confirmed early)

### Time Efficiency Evidence

**Sprint 17** (with progressive testing):
- Phase 1: 30 min
- Phase 2: 16.5 sec (caught failure)
- **Total**: 1.5 hours
- **Saved**: 5.5 hours (3.7× faster)

**If run full pipeline**:
- Phases 1-5: ~7 hours
- Result: Same failure confirmation
- **Efficiency**: Progressive testing 3.7× faster

### Implementation Guidelines

**1. Git Commits at Each Phase**:
```bash
git commit -m "Phase 1: Datapoints test - code compiles"
git commit -m "Phase 2: BTCUSDT test - strategy shows promise (Sharpe 1.8)"
git commit -m "Phase 3: 3-coin test - generalizes well"
# etc.
```

**2. Phase 2 NSGA-2 Settings** (smaller, faster):
```python
# DON'T use production settings for Phase 2
population_size = 24  # Not 64 or 128
num_generations = 24  # Not 64 or 128
# Total evals: 576 (fast enough to iterate)
```

**3. Data Analysis After Phase 2**:
- Check parameter distributions (boundary convergence?)
- Check signal frequency (too rare/common?)
- Check PNL distribution (all negative?)
- Check Sharpe median (< 0 = red flag)

**4. RED FLAGS for ABORT**:
- ❌ All Pareto solutions negative PNL (Sprint 17: -$4.21)
- ❌ Parameters at boundaries (Sprint 17: 0.12/0.90)
- ❌ Trade frequency < 20/year (insufficient data)
- ❌ Trade frequency > 2000/year (overtrading, likely spurious)
- ❌ Median Sharpe < 0 (strategy loses money)

**5. GREEN SIGNALS for PROCEED**:
- ✅ Positive median PNL
- ✅ Parameters in mid-range (not at boundaries)
- ✅ Sharpe > 1.0
- ✅ Trade frequency 50-500/year (reasonable)

### Key Insight

**Phase 2 is the CRITICAL gate**:
- If 1 coin fails with abundant signals → strategy is broken
- If 1 coin succeeds → likely generalizes to other coins
- Don't waste time on 11 coins if 1 coin proves fundamental failure
- BTCUSDT is ideal benchmark (most liquid, representative of crypto)

### Application to Other Domains

This pattern applies beyond trading strategies:
- ML model training: Small dataset → Medium → Full → Production
- API load testing: 1 req/sec → 10 → 100 → 1000
- Database migrations: Test table → Staging → Production
- **Universal principle**: Test small, fail fast, scale up only on success

**Tags:** #process #testing #efficiency #progressive-testing #time-management #quant #backtesting #success #workflow

**Memory Type:** procedural (repeatable workflow pattern)

**Frequency:** Apply to EVERY new strategy development

**Confidence Level:** HIGH (proven in Sprint 14 success detection + Sprint 17 failure detection)

**Role Collection:** quant

**Created:** 2025-11-29
**Sprint Context:** Sprint 14 (success path) vs Sprint 17 (failure detection)
