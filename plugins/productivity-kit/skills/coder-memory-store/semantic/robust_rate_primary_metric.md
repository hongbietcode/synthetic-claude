**Title:** Robust Rate as Primary Success Metric

**Description:** Robust rate (% of Pareto solutions profitable on ALL OOS periods) is the primary metric for strategy success, not training Sharpe. High training Sharpe without OOS validation is meaningless. Sprint 14 achieved 31.61% robust rate (excellent), Sprint 11 had 0.1% (overfitting catastrophe).

**Content:**

### The Metric That Matters

**Definition**:
```
Robust Rate = (Solutions profitable on ALL OOS periods) / (Total Pareto solutions)
```

**Why This Metric**:
- Training Sharpe alone: Meaningless (easy to overfit)
- Single OOS period: Can get lucky with regime match
- Multiple OOS periods: Proves strategy works across regimes
- Robust rate: Quantifies generalization quality

### Evidence from Sprint History

**Sprint 15 - Pairs Trading** (overfitting catastrophe):
```
Training Sharpe: 21.59 (looks amazing!)
OOS Sharpe: -1.43 (complete failure)
Robust Rate: ~0%
Diagnosis: Catastrophic overfitting
```

**Sprint 11 - RSI+ADX Mean-Reversion** (regime-specific):
```
Training Sharpe: ~2.5
OOS Sharpe: Mostly negative
Robust Rate: 0.1%
Diagnosis: Regime-specific, doesn't generalize
```

**Sprint 10 - Dual MA** (acceptable):
```
Training Sharpe: ~2.0
OOS Sharpe: ~1.5
Robust Rate: 13.1%
Diagnosis: Acceptable generalization
```

**Sprint 14 - BB Mean-Reversion** (excellent):
```
Training Sharpe: 2.13
OOS Sharpe: 1.20
Robust Rate: 31.61%
Diagnosis: Excellent generalization (2.4× better than Sprint 10)
```

### Robust Rate Benchmarks

**< 5%**: Catastrophic (regime-specific, don't deploy)
- Example: Sprint 11 at 0.1%
- Interpretation: Strategy found regime-specific patterns, not universal edge

**5-10%**: Poor (barely generalizes)
- Interpretation: Strategy might work in specific regimes
- Action: Proceed with caution, additional validation needed

**10-20%**: Acceptable (standard quant strategy)
- Example: Sprint 10 at 13.1%
- Interpretation: Strategy has genuine edge but limited robustness
- Action: Deploy with risk management

**20-30%**: Good (above-average generalization)
- Interpretation: Strategy generalizes well across regimes
- Action: Deploy with confidence

**30%+**: Excellent (rare, high-quality strategy)
- Example: Sprint 14 at 31.61%
- Interpretation: Strategy found robust market inefficiency
- Action: Deploy as core strategy

**> 50%**: Suspicious (check for bugs)
- Possible data leakage
- Possible validation code bug
- Requires careful audit

### Two OOS Periods Are CRITICAL

**Why Not One OOS Period?**
```
Scenario: Test only on 2024-2025 (bull market)
Result: 80% robust rate (amazing!)
Problem: Strategy is just "buy and hold" in bull market
Reality: Would fail in 2022 bear market
```

**Sprint 14 Methodology**:
```
Training: 2023-2024 (2 years, mixed regimes)

OOS Period 1: 2022 (bear market)
OOS Period 2: 2024-2025 (bull/sideways)

Robust Criteria:
- Solution must be profitable on 2023-2024 (training)
- AND profitable on 2022 (OOS1)
- AND profitable on 2024-2025 (OOS2)

Result: 31.61% of solutions met all three criteria
```

**Why This Works**:
- 2022: Bear market regime
- 2023-2024: Mixed (training period)
- 2024-2025: Bull/sideways regime
- If profitable across all three → strategy is regime-independent

### Red Flags in Validation

**1. Training Sharpe > 10**:
```
Sprint 15: Training Sharpe 21.59
Red Flag: Suspiciously high (likely overfitting)
Confirmed: OOS Sharpe -1.43 (overfitting confirmed)
```

**2. OOS Sharpe > Training Sharpe**:
```
Training Sharpe: 2.0
OOS Sharpe: 3.5
Red Flag: Suspicious (possible data leakage)
Action: Audit validation code for bugs
```

**3. High Robust Rate on OOS1, Zero on OOS2**:
```
OOS1 (2022) robust rate: 45%
OOS2 (2024) robust rate: 0%
Red Flag: Regime-specific (not truly robust)
Action: Strategy only works in bear markets
```

**4. Robust Rate < Training Success Rate**:
```
Training: 80% of solutions profitable
OOS: 5% robust rate
Red Flag: Massive overfitting
Action: Strategy learned training noise, not signal
```

### Sprint 14 Validation Journey

**Initial Assessment**:
```
Robust Rate: 45.45% (looked amazing!)
Team Reaction: "Best strategy yet!"
```

**Bug Discovery**:
```
Code Review: Found off-by-one error in OOS validation
Impact: Validation period included 1 training candle
Reality: Data leakage inflated metrics
```

**Corrected Assessment**:
```
Robust Rate: 31.61% (after bug fix)
Team Reaction: "Still excellent, but honest"
Lesson: Validate the validation code!
```

**Key Takeaway**: Even validation code has bugs. Cross-check results, audit code, look for suspiciously good metrics.

### Implementation Checklist

**1. Training Period Selection**:
```python
# Good: Covers multiple regimes
training_start = "2023-01-01"
training_end = "2024-12-31"  # 2 years, bull + bear + sideways

# Bad: Single regime
training_start = "2024-01-01"  # Only bull market
```

**2. OOS Period Selection**:
```python
# Good: Two different regimes
oos_period_1 = ("2022-01-01", "2022-12-31")  # Bear market
oos_period_2 = ("2024-01-01", "2025-10-31")  # Bull/sideways

# Bad: Adjacent periods (same regime)
oos_period_1 = ("2024-01-01", "2024-06-30")
oos_period_2 = ("2024-07-01", "2024-12-31")
```

**3. Robust Rate Calculation**:
```python
def calculate_robust_rate(pareto_solutions, oos_periods):
    """
    Calculate percentage of solutions profitable on ALL OOS periods.
    """
    robust_count = 0

    for solution in pareto_solutions:
        profitable_on_all = True

        for period in oos_periods:
            pnl = backtest(solution, period)
            if pnl <= 0:
                profitable_on_all = False
                break

        if profitable_on_all:
            robust_count += 1

    return robust_count / len(pareto_solutions)
```

**4. Reporting Format**:
```
Strategy: Bollinger Bands Mean-Reversion
Training Period: 2023-2024 (2 years)
Training Median Sharpe: 2.13

OOS Period 1: 2022
OOS Period 2: 2024-2025
Robust Rate: 31.61% (excellent)

Interpretation: 31.61% of Pareto solutions profitable on training + both OOS periods
Benchmark: >30% is excellent, >20% is good, >10% is acceptable
Recommendation: Deploy as core strategy
```

### Application Guidelines

**1. NEVER Trust Training Metrics Alone**:
```python
# Bad reporting
print(f"Strategy Sharpe: {training_sharpe:.2f}")  # Meaningless alone

# Good reporting
print(f"Training Sharpe: {training_sharpe:.2f}")
print(f"OOS Sharpe: {oos_sharpe:.2f}")
print(f"Robust Rate: {robust_rate:.1%}")
print(f"Assessment: {'EXCELLENT' if robust_rate > 0.3 else 'GOOD' if robust_rate > 0.2 else 'ACCEPTABLE' if robust_rate > 0.1 else 'POOR'}")
```

**2. ALWAYS Validate on 2+ OOS Periods**:
- Different time periods (not adjacent)
- Different market regimes (bull, bear, sideways)
- Sufficient data (≥1 year per period)

**3. Robust Rate > 10% Minimum**:
- If < 10%: Don't deploy (regime-specific)
- If 10-20%: Deploy with caution
- If > 20%: Deploy with confidence
- If > 30%: Deploy as core strategy

**4. Audit Validation Code**:
```python
# Common bugs
1. Off-by-one errors (including training data in OOS)
2. Look-ahead bias (using future data)
3. Data leakage (OOS period overlaps training)
4. Timezone errors (candle alignment issues)

# Sprint 14 lesson: Even with 31.61%, verify the code
```

### Cross-Domain Application

This principle applies beyond trading:
- **ML models**: Test set accuracy alone is insufficient, need multiple test sets
- **A/B testing**: Test on multiple user cohorts, not just one
- **Load testing**: Test across multiple time periods, not just one day

**Universal principle**: Generalization must be proven across multiple independent validation sets, not assumed from single-period performance.

### Critical Insight

**Training performance shows capability**
**OOS performance shows generalization**
**Robust rate quantifies reliability**

Only robust rate tells you: "What percentage of my strategies will work in production?"

**Tags:** #validation #robust-rate #oos #overfitting #metrics #success-criteria #quant #backtesting #generalization

**Memory Type:** semantic (validation methodology principle)

**Frequency:** Apply to EVERY strategy validation

**Confidence Level:** VERY HIGH (proven across Sprint 10/11/14/15/17 with consistent predictive power)

**Role Collection:** quant

**Created:** 2025-11-29
**Sprint Context:** Sprint 14 (31.61% robust), Sprint 11 (0.1% failure), Sprint 15 (overfitting), Sprint 10 (13.1% acceptable)
