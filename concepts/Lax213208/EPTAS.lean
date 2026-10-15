import Lax213208.ApproximationScheme
import Mathlib.Computability.Partrec

/-!
---
title: Efficient polynomial-time approximation schemes
type: definition
---
A program is an efficient polynomial-time approximation scheme (EPTAS)
on an input class if, for every real $\varepsilon>0$, it returns a
$(1+\varepsilon)$-approximation in time $f(K(\varepsilon))(n+2)^d$,
where $d$ is a fixed positive integer,
$K(\varepsilon)=\max\{1,\lceil1/\varepsilon\rceil\}$ is the supplied precision,
and $f$ is a total computable function, positive on positive integers.

The exponent of the instance size is independent of accuracy.
The coefficient may have arbitrary computable dependence on the supplied precision.
Both the function and exponent are chosen before the accuracy and instance.
This uses the effective convention for parameter dependence: the bound
as a function of the integer precision must be computable, even for an
arbitrary promise class. This avoids imposing a notion of exact real computation
on the function describing the accuracy dependence.
-/

namespace Lax213208.EPTAS

open OptimizationProblem Programs ApproximationScheme

def EPTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∃ f : ℕ → ℕ, Computable f ∧
    (∀ k : ℕ, 0 < k → 0 < f k) ∧
    ∃ d : ℕ, 0 < d ∧ ∀ ε : ℝ, 0 < ε →
      ApproximatesWithin (problem := problem) alg inputs ε
        (fun n => f (precision ε) * (n + 2) ^ d)

end Lax213208.EPTAS
