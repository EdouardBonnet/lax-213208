import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Fully polynomial-time approximation schemes
type: definition
---
An FPTAS has ratio $1+\varepsilon$, with $\varepsilon=1/k$, in time
polynomial in both instance size and $k$. The constants and exponents
are independent of the instance and precision.
-/

namespace Lax213208.FPTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def FPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∃ c d e : ℕ, 0 < c ∧ 0 < d ∧ 0 < e ∧
    ∀ k : ℕ, 0 < k →
      let ε : ℝ := 1 / k
      Approximates (problem := problem) alg inputs (1 + ε) (some k) ∧
      RunsInTime (problem := problem) alg inputs
        (fun n => c * (n + 2) ^ d * (k + 1) ^ e) (some k)

end Lax213208.FPTAS
