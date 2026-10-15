import Lax213208.OptimizationProblem
import Lax560851.StructuralCombinators

/-!
---
title: Algorithm inputs
type: definition
---
An ordinary algorithm receives the instance's structural arena.
A scheme receives the arena of $(k,x)$, where the positive integer $k$
specifies accuracy $\varepsilon=1/k$. Only the integer is machine input.
-/

namespace Lax213208.AlgorithmInput

open OptimizationProblem
open Lax560851.WordArena Lax560851.StructuralCombinators

variable {Instance Solution : Type*}

def inputTape (problem : Problem Instance Solution)
    (precision : Option ℕ) (x : Instance) : List ℕ :=
  match precision with
  | none => inputWords problem x
  | some k => (encode (prod nat problem.input) (k, x)).toInput

end Lax213208.AlgorithmInput
