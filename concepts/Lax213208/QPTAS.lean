import Lax213208.ApproximationScheme
import Mathlib.Data.Nat.Log

/-!
---
title: Quasipolynomial-time approximation schemes
type: definition
---
A program is a quasipolynomial-time approximation scheme (QPTAS) on an
input class if, for each fixed real $\varepsilon>0$, it returns a
$(1+\varepsilon)$-approximation in time $2^{(\log(n+2))^{O_\varepsilon(1)}}$.

For every positive real $\varepsilon$ there are positive integers $c,d$ bounding the
running time on every $n$-bit instance by
$2^{c(1+\lfloor\log_2(n+2)\rfloor)^d}$.
Both the coefficient and the logarithmic exponent may depend on $\varepsilon$.
This is the general fixed-accuracy definition; it does not require
polynomial dependence on $1/\varepsilon$ inside the exponent.

The displayed bound also bounds the sufficient word length in bits, following
`RunsWithin`. Instance size is the binary size of the fixed structural arena.
-/

namespace Lax213208.QPTAS

open OptimizationProblem Programs ApproximationScheme

universe u v

def QPTAS {α : Type u} {β : Type v} {problem : Problem α β}
    (alg : Program) (inputs : InputClass α) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ApproximatesWithin (problem := problem) alg inputs ε
      (fun n => 2 ^ (c * (Nat.log2 (n + 2) + 1) ^ d))

end Lax213208.QPTAS
