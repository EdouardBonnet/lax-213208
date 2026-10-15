import Mathlib.Data.NNReal.Basic
import Mathlib.Data.Set.Basic
import Lax560851.WordArena
import Lax759944.BinaryWordEncoding

/-!
---
title: Optimization problems
type: definition
---
An optimization problem specifies feasible solutions, nonnegative objective
values, and whether to minimize or maximize. Instances and solutions are
typed mathematical objects with fixed, injective representations.
Input size is the binary size of the instance's structural arena.

The predicates are relative to these representations. Input presentations
should come from the archive's structural combinators or certified
constructor derivations; injectivity alone does not exclude encoded advice.
-/

namespace Lax213208.OptimizationProblem

open scoped NNReal
open Lax560851.StructuralPresentation Lax560851.WordArena
open Lax759944.BinaryWordEncoding

inductive Direction
  | minimize
  | maximize

structure Problem (Instance Solution : Type*) where
  direction : Direction
  feasible : Instance → Solution → Prop
  value : Instance → Solution → ℝ≥0
  input : Presentation Instance
  output : Solution → List ℕ
  input_faithful : input.Faithful
  output_injective : Function.Injective output

variable {Instance Solution : Type*}

def inputWords (problem : Problem Instance Solution) (x : Instance) : List ℕ :=
  (encode problem.input x).toInput

def inputSize (problem : Problem Instance Solution) (x : Instance) : ℕ :=
  bitSize (inputWords problem x)

end Lax213208.OptimizationProblem
