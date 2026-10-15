import Lax213208.Approximation
import Lax213208.Programs

/-!
---
title: Polynomial-time r-approximation algorithms
type: definition
---
A program is an $r$-approximation algorithm on an input class if $r\ge1$
and on every instance in the class it returns an $r$-approximate feasible
solution in polynomial time. The program receives only the instance;
the fixed ratio is not an additional input.

Explicitly, there are positive integers $c,d$ such that the running time
on every instance of binary size $n$ is at most $c(n+2)^d$.
The same bound is a sufficient word length in bits, as in `RunsWithin`.
The constants may depend on the program, problem, class, and fixed ratio,
but not on the instance. The shift by two includes empty inputs.
-/

namespace Lax213208.RApproximation

open scoped NNReal

open OptimizationProblem Programs Approximation

universe u v

def RApproximation {α : Type u} {β : Type v} {problem : Problem α β}
    (alg : Program) (inputs : InputClass α) (r : ℝ≥0) : Prop :=
  1 ≤ r ∧ ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ∀ x ∈ inputs, ∃ y,
      IsApproximation problem r x y ∧
      RunsWithin alg problem.input problem.output x y
        (c * (inputSize problem x + 2) ^ d)

end Lax213208.RApproximation
