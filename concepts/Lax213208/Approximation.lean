import Lax213208.OptimizationProblem

/-!
---
title: Multiplicative approximation
type: definition
---
For $r\ge1$, a feasible solution is an $r$-approximation if its value is
at most $r$ times the optimum in a minimization problem, or at least
$1/r$ times the optimum in a maximization problem.

We express the guarantee by comparison with every feasible solution:
$v(x,y)\le r\,v(x,z)$ for minimization, and
$v(x,z)\le r\,v(x,y)$ for maximization. Thus no chosen optimum or division
by an objective value is needed. The definition handles optimum zero
and remains meaningful when an optimum is not attained. An infeasible
instance has no approximate solution, because the output must be feasible.
-/

namespace Lax213208.Approximation

open scoped NNReal

open OptimizationProblem

universe u v

def IsApproximation {α : Type u} {β : Type v}
    (problem : Problem α β) (r : ℝ≥0) (x : α) (y : β) : Prop :=
  1 ≤ r ∧ problem.feasible x y ∧
    ∀ z, problem.feasible x z →
      match problem.direction with
      | .minimize => problem.value x y ≤ r * problem.value x z
      | .maximize => problem.value x z ≤ r * problem.value x y

end Lax213208.Approximation
