import Mathlib.Data.NNReal.Basic
import Mathlib.Data.Set.Basic
import Lax560851.WordArena
import Lax759944.BinaryWordEncoding

/-!
---
title: Optimization problems on typed instances and solutions
type: definition
---
An optimization problem has an instance type $\alpha$ and a solution type
$\beta$. It specifies whether to minimize or maximize, feasibility, and a
nonnegative real objective value. An input class is a set of values of
$\alpha$, such as graphs or weighted instances; feasibility and objectives
are stated directly on mathematical objects.

Instances use a fixed faithful structural presentation from Lax560851;
solutions have a fixed injective word-list encoding. The size of an instance
is Lax759944's binary size of its distinguished input arena, including all
numerical payloads. Representations are fixed with the problem, before the
algorithm and input class are chosen.

The problem and the input class are fixed when discussing an algorithm.
No behavior is prescribed outside the class. Feasibility and objective
evaluation are not assumed polynomial-time computable: these definitions
apply to optimization problems in general, not just NPO problems.
Objective values on infeasible pairs are ignored.

# Formalization notes

These are complexity predicates relative to the specified representations.
Faithfulness prevents collisions, but does not certify that a representation
contains no precomputed information. Authors should use Lax560851's fixed
structural combinators or certified constructor derivations for inputs.
The output convention may be its one-word natural or Boolean encoding,
or an arena encoding for a structured solution.
-/

namespace Lax213208.OptimizationProblem

open scoped NNReal

open Lax560851.StructuralPresentation Lax560851.WordArena
open Lax759944.BinaryWordEncoding

universe u v

inductive Direction
  | minimize
  | maximize

structure Problem (α : Type u) (β : Type v) where
  direction : Direction
  feasible : α → β → Prop
  value : α → β → ℝ≥0
  input : Presentation α
  output : β → List ℕ
  input_faithful : input.Faithful
  output_injective : Function.Injective output

abbrev InputClass (α : Type u) := Set α

def inputSize {α : Type u} {β : Type v} (problem : Problem α β) (x : α) : ℕ :=
  bitSize (encode problem.input x).toInput

end Lax213208.OptimizationProblem
