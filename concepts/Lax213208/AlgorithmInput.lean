import Lax213208.OptimizationProblem
import Lax560851.StructuralCombinators
import Mathlib.Data.Real.Archimedean

/-!
---
title: Algorithm inputs
type: definition
---
An ordinary algorithm receives the instance's structural arena.
At requested real accuracy $\varepsilon>0$, a scheme receives the arena
of $(\max\{1,\lceil1/\varepsilon\rceil\},x)$.

The integer supplies finite precision; the approximation guarantee uses
the real $\varepsilon$. This specifies the finite input, without assuming
that a machine can read an arbitrary real exactly.
-/

namespace Lax213208.AlgorithmInput

open OptimizationProblem
open Lax560851.WordArena Lax560851.StructuralCombinators

variable {Instance Solution : Type*}

noncomputable def precision (ε : ℝ) : ℕ :=
  max 1 ⌈ε⁻¹⌉₊

noncomputable def inputTape (problem : Problem Instance Solution)
    (accuracy : Option ℝ) (x : Instance) : List ℕ :=
  match accuracy with
  | none => inputWords problem x
  | some ε => (encode (prod nat problem.input) (precision ε, x)).toInput

end Lax213208.AlgorithmInput
