import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Fully polynomial-time approximation schemes
type: definition
---
An FPTAS has ratio $1+\varepsilon$ in time polynomial in both instance
size and $1/\varepsilon$. The constants and exponents are independent
of the instance and accuracy.
-/

namespace Lax213208.FPTAS

open OptimizationProblem Programs AlgorithmInput RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def FPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∃ c d e : ℕ, 0 < c ∧ 0 < d ∧ 0 < e ∧
    ∀ ε : ℝ, 0 < ε →
      Approximates (problem := problem) alg inputs (1 + ε) (some ε) ∧
      RunsInTime (problem := problem) alg inputs
        (fun n => c * (n + 2) ^ d * (precision ε + 1) ^ e) (some ε)

end Lax213208.FPTAS
