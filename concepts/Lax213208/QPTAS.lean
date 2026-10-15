import Lax213208.RApproximation
import Lax213208.RunningTime

/-!
---
title: Quasipolynomial-time approximation schemes
type: definition
---
A QPTAS has approximation ratio $1+\varepsilon$ and quasipolynomial
running time for every fixed $\varepsilon=1/k$, where $k$ is a positive integer.
-/

namespace Lax213208.QPTAS

open OptimizationProblem Programs RApproximation RunningTime

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def QPTAS (alg : Program) (inputs : Set Instance) : Prop :=
  ∀ k : ℕ, 0 < k →
    let ε : ℝ := 1 / k
    Approximates (problem := problem) alg inputs (1 + ε) (some k) ∧
    QuasipolynomialTime (problem := problem) alg inputs (some k)

end Lax213208.QPTAS
