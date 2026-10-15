import Lax808846.RamComputes
import Lax759944.RamPolytime

/-!
---
title: Program execution
type: definition
---
We use the archive's word-RAM programs. An output is returned if it is
produced at every sufficiently large word width. This is an execution
relation, not a computability claim or a running-time bound.

A resource bound $T$ guarantees that input words and length fit in $T$ bits,
and that the same output is produced within $T$ instructions at every
width at least $T$. Lax62's compilation theorems establish the underlying
`ComputesInTime` judgment from high-level program specifications.
-/

namespace Lax213208.Programs

open Lax808846.Ram Lax808846.RamComputes Lax759944.RamPolytime

abbrev Program := Lax808846.Ram.Program

def Returns (alg : Program) (input output : List ℕ) : Prop :=
  ∃ width : ℕ, ∀ w ≥ width, ∃ steps, RunsTo w alg input output steps

def RunsWithin (alg : Program) (input output : List ℕ) (bound : ℕ) : Prop :=
  FitsInWords bound (input.length :: input) ∧
    ∀ w ≥ bound, ComputesInTime w alg {input} (fun _ => output) (fun _ => bound)

end Lax213208.Programs
