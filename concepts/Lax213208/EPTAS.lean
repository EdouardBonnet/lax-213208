import Lax213208.ApproximationScheme
import Mathlib.Computability.Partrec

/-!
---
title: Efficient polynomial-time approximation schemes
type: definition
---
A program is an efficient polynomial-time approximation scheme (EPTAS)
on an input class if it returns a $(1+1/k)$-approximation in time
$f(k)(n+2)^d$, where $d$ is a fixed positive integer and $f$ is a total
computable function, positive on positive integers.

The exponent of the instance size is independent of accuracy.
The coefficient may have arbitrary computable dependence on $k$.
Both the function and exponent are chosen before the accuracy and instance.
This uses the effective convention for parameter dependence: the bound
as a function of $k$ must be computable, even for an arbitrary promise class.
-/

namespace Lax213208.EPTAS

open OptimizationProblem Programs ApproximationScheme

def EPTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∃ f : ℕ → ℕ, Computable f ∧
    ∃ d : ℕ, 0 < d ∧ ∀ k : ℕ, 0 < k → 0 < f k ∧
      ApproximatesWithin (problem := problem) alg inputs k
        (fun n => f k * (n + 2) ^ d)

end Lax213208.EPTAS
