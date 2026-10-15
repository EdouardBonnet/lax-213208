import Lax213208.Approximation
import Lax213208.Programs

/-!
---
title: Approximation within a resource bound
type: definition
---
A program approximates a problem within ratio $r\ge1$ and resource bound
$T$ on an input class if, on each instance $x$ in the class, it returns
a feasible $r$-approximate solution within $T(n)$ instructions, with
$T(n)$ also a sufficient word length in bits. Here $n$ is the binary
size of the instance under the problem's fixed representation.

This is the common predicate for fixed-ratio algorithms and approximation
schemes. It separates the instance whose solution is sought from the
argument supplied to the program: a fixed-ratio algorithm receives $x$,
whereas a scheme receives the pair of the requested precision and $x$.
The input presentation and argument map make that calling convention
explicit. The derived complexity predicates fix these maps themselves;
they do not existentially choose an encoding or preprocessing function.

The condition $r\ge1$ is required even for an empty input class.
-/

namespace Lax213208.ApproximationAlgorithm

open scoped NNReal

open OptimizationProblem Programs Approximation
open Lax560851.StructuralPresentation

universe u v w

/-- Shared approximation guarantee and resource bound, with an explicit calling convention. -/
def ApproximatesWithin {α : Type u} {β : Type v} {ι : Type w}
    {problem : Problem α β} (alg : Program) (inputs : InputClass α)
    (r : ℝ≥0) (T : ℕ → ℕ) (input : Presentation ι) (argument : α → ι) : Prop :=
  1 ≤ r ∧ ∀ x ∈ inputs, ∃ y,
    IsApproximation problem r x y ∧
    RunsWithin alg input problem.output (argument x) y (T (inputSize problem x))

end Lax213208.ApproximationAlgorithm
