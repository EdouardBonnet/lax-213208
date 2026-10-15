import Lax213208.Approximation
import Lax213208.AlgorithmInput
import Lax213208.Programs

/-!
---
title: Approximation guarantees
type: definition
---
A program approximates within $r\ge1$ if it returns a feasible
$r$-approximate solution on every instance in the class. This requires
termination, with no restriction on running time.

The optional accuracy selects the scheme input convention. Both ordinary
algorithms and schemes use this same predicate.
-/

namespace Lax213208.RApproximation

open OptimizationProblem Approximation AlgorithmInput Programs

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def Approximates (alg : Program) (inputs : Set Instance) (r : ℝ)
    (accuracy : Option ℝ := none) : Prop :=
  1 ≤ r ∧ ∀ x ∈ inputs, ∃ y,
    Returns alg (inputTape problem accuracy x) (problem.output y) ∧
    IsApproximation problem r x y

end Lax213208.RApproximation
