import Lax213208.RApproximation
import Lax213208.RunningTime
import Mathlib.Computability.Partrec

/-!
---
title: Efficient polynomial-time approximation schemes
type: definition
---
An EPTAS has ratio $1+\varepsilon$, with $\varepsilon=1/k$, in time
$f(k)(n+2)^d$, where $f$ is computable and the exponent $d$ is
independent of precision.
-/

namespace Lax213208.EPTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def EPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∃ f : ℕ → ℕ, Computable f ∧ (∀ k > 0, 0 < f k) ∧
    ∃ d : ℕ, 0 < d ∧ ∀ k : ℕ, 0 < k →
      let ε : ℝ := 1 / k
      Approximates (problem := problem) alg inputs (1 + ε) (some k) ∧
      RunsInTime (problem := problem) alg inputs
        (fun n => f k * (n + 2) ^ d) (some k)

end Lax213208.EPTAS
