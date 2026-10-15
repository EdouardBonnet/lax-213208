import Mathlib.Data.NNReal.Basic
import Mathlib.Data.Set.Basic

/-!
---
title: Encoded optimization problems
type: definition
---
An optimization problem specifies whether to minimize or maximize, which
binary strings encode feasible solutions to each binary-encoded instance,
and a nonnegative real objective value for each instance-solution pair.
An input class is a set of encoded instances. Their size is their bit length,
including all numerical data in the chosen encoding.

The problem and the input class are fixed when discussing an algorithm.
No behavior is prescribed outside the class. Feasibility and objective
evaluation are not assumed polynomial-time computable: these definitions
apply to optimization problems in general, not just NPO problems.
Objective values on infeasible pairs are ignored.
-/

namespace Lax213208.OptimizationProblem

open scoped NNReal

inductive Direction
  | minimize
  | maximize

structure Problem where
  direction : Direction
  feasible : List Bool → List Bool → Prop
  value : List Bool → List Bool → ℝ≥0

abbrev InputClass := Set (List Bool)

end Lax213208.OptimizationProblem
