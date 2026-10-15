import Lax213208.ApproximationScheme
import Mathlib.Data.Nat.Log

/-!
---
title: Quasipolynomial-time approximation schemes
type: definition
---
A program is a quasipolynomial-time approximation scheme (QPTAS) on an
input class if, for each fixed $k\ge1$, it returns a
$(1+1/k)$-approximation in time $2^{(\log(n+2))^{O_k(1)}}$.

For every positive $k$ there are positive integers $c,d$ bounding the
running time on every $n$-bit instance by
$2^{c(1+\lfloor\log_2(n+2)\rfloor)^d}$.
Both the coefficient and the logarithmic exponent may depend on $k$.
This is the general fixed-accuracy definition; it does not require
polynomial dependence on $k$ inside the exponent.
-/

namespace Lax213208.QPTAS

open OptimizationProblem Programs ApproximationScheme

def QPTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∀ k : ℕ, 0 < k → ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ApproximatesWithin (problem := problem) alg inputs k
      (fun n => 2 ^ (c * (Nat.log2 (n + 2) + 1) ^ d))

end Lax213208.QPTAS
