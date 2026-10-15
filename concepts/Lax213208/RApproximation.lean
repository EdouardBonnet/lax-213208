import Lax213208.ApproximationAlgorithm

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
This specializes the shared `ApproximatesWithin` predicate to ratio $r$
and the identity argument map, with no accuracy parameter on the input.
-/

namespace Lax213208.RApproximation

open scoped NNReal

open OptimizationProblem Programs ApproximationAlgorithm

universe u v

def RApproximation {α : Type u} {β : Type v} {problem : Problem α β}
    (alg : Program) (inputs : InputClass α) (r : ℝ≥0) : Prop :=
  ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ApproximatesWithin (problem := problem) alg inputs r
      (fun n => c * (n + 2) ^ d) problem.input id

end Lax213208.RApproximation
