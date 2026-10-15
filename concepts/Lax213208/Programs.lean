import Lax808846.RamComputes
import Lax759944.RamPolytime
import Lax560851.RamComplexity

/-!
---
title: Resource-bounded programs on typed data
type: definition
---
Programs are the existing deterministic word-RAM programs of Lax808846.
Inputs are mathematical values, supplied through Lax560851's structural
presentations and distinguished word arenas. Outputs use a fixed encoding
of mathematical solutions. Running time is the machine's instruction count,
including production of the complete output and an executed terminal instruction.

`RunsWithin alg input output x y T` requires the program to return the
encoding of $y$ on the arena of $x$ within $T$ instructions, at every word
length at least $T$. The input entries and input length must already fit
at that sufficient width. Thus the guarantee is uniform in word length
and is not vacuous because an input fails to fit.

The same budget bounds instructions and sufficient word bits. Bounding
word bits is essential when measuring complexity in binary input size.
For the polynomial and quasipolynomial families used here, independently
obtained bounds on time and sufficient word bits can be dominated by a
single bound of the same family after enlarging its constants and exponents.
The word-length bound is a sufficient width, not an upper limit on execution.

# Formalization notes

`Program` is only an abbreviation for `Lax808846.Ram.Program`; no new
machine or execution semantics is introduced. The resource predicate uses
the existing `ComputesInTime` directly. The program is explicit so that a
running-time claim concerns a particular implementation, not merely the
existence of some fast implementation of the same function.

Submitters can define this program by compilation from Lax62's high-level
imperative language and establish its bound with the refinement framework.
In particular, `Lax62Proofs.Codegen.computesInTime_of_spec` concludes the
`ComputesInTime` obligation below from a high-level specification and cost.
That proof infrastructure is used by downstream proof packages; these
definitions depend only on the existing concept interfaces.
-/

namespace Lax213208.Programs

open Lax560851.StructuralPresentation Lax560851.WordArena
open Lax759944.RamPolytime Lax808846.RamComputes

universe u v

/-- The archive's existing word-RAM program type, including compiled programs. -/
abbrev Program := Lax808846.Ram.Program

/-- An exact typed result within a common time and sufficient-word-bits budget. -/
def RunsWithin {α : Type u} {β : Type v} (alg : Program)
    (input : Presentation α) (output : β → List ℕ)
    (x : α) (y : β) (T : ℕ) : Prop :=
  let tape := (encode input x).toInput
  FitsInWords T (tape.length :: tape) ∧
    ∀ w : ℕ, T ≤ w →
      ComputesInTime w alg {tape} (fun _ => output y) (fun _ => T)

end Lax213208.Programs
