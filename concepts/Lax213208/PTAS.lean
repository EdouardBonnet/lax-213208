import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Polynomial-time approximation schemes
type: definition
---
A PTAS has approximation ratio $1+\varepsilon$ and polynomial running
time for every fixed real $\varepsilon>0$. One program handles all accuracies.
-/

namespace Lax213208.PTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def PTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    Approximates (problem := problem) alg inputs (1 + ε) (some ε) ∧
    PolynomialTime (problem := problem) alg inputs (some ε)

end Lax213208.PTAS
