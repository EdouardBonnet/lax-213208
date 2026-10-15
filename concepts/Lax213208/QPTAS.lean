import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Quasipolynomial-time approximation schemes
type: definition
---
A QPTAS has approximation ratio $1+\varepsilon$ and quasipolynomial
running time for every fixed real $\varepsilon>0$.
-/

namespace Lax213208.QPTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def QPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∀ ε : ℝ, 0 < ε →
    Approximates (problem := problem) alg inputs (1 + ε) (some ε) ∧
    QuasipolynomialTime (problem := problem) alg inputs (some ε)

end Lax213208.QPTAS
