import Lax213208.OptimizationProblem

/-!
---
title: Approximate and optimal solutions
type: definition
---
For $r\ge1$, an $r$-approximate solution is feasible and has value at most
$r\,\mathrm{OPT}$ for minimization, or at least $\mathrm{OPT}/r$ for
maximization. Comparison with every feasible solution avoids division by
zero and does not require an attained optimum.

An optimal value, when needed, is the value of an attained optimum.
-/

namespace Lax213208.Approximation

open OptimizationProblem

variable {Instance Solution : Type*}

def IsApproximation (problem : Problem Instance Solution)
    (r : ℝ) (x : Instance) (y : Solution) : Prop :=
  1 ≤ r ∧ problem.feasible x y ∧ ∀ z, problem.feasible x z →
    match problem.direction with
    | .minimize => (problem.value x y : ℝ) ≤ r * problem.value x z
    | .maximize => (problem.value x z : ℝ) ≤ r * problem.value x y

def IsOptimalValue (problem : Problem Instance Solution)
    (x : Instance) (value : ℝ) : Prop :=
  ∃ y, IsApproximation problem 1 x y ∧ (problem.value x y : ℝ) = value

end Lax213208.Approximation
