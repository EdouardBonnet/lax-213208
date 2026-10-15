import Lax213208.RApproximation
import Lax213208.RunningTime
import Mathlib.Computability.Partrec

/-!
---
title: Efficient polynomial-time approximation schemes
type: definition
---
An EPTAS has ratio $1+\varepsilon$ in time $f(K)(n+2)^d$, where
$K=\max\{1,\lceil1/\varepsilon\rceil\}$, $f$ is computable, and the
exponent $d$ is independent of accuracy.
-/

namespace Lax213208.EPTAS

open OptimizationProblem Programs AlgorithmInput RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def EPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∃ f : ℕ → ℕ, Computable f ∧ (∀ k > 0, 0 < f k) ∧
    ∃ d : ℕ, 0 < d ∧ ∀ ε : ℝ, 0 < ε →
      Approximates (problem := problem) alg inputs (1 + ε) (some ε) ∧
      RunsInTime (problem := problem) alg inputs
        (fun n => f (precision ε) * (n + 2) ^ d) (some ε)

end Lax213208.EPTAS
