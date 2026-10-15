import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Polynomial-time approximation schemes
type: definition
---
A PTAS has approximation ratio $1+\varepsilon$ and polynomial running
time for every fixed $\varepsilon=1/k$, where $k$ is a positive integer.
One program handles all precisions.
-/

namespace Lax213208.PTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def PTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∀ k : ℕ, 0 < k →
    let ε : ℝ := 1 / k
    Approximates (problem := problem) alg inputs (1 + ε) (some k) ∧
    PolynomialTime (problem := problem) alg inputs (some k)

end Lax213208.PTAS
