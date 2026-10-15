import Mathlib.Computability.TuringMachine.Computable

/-!
---
title: Programs on binary strings
type: definition
---
A program is a deterministic finite multi-stack Turing machine with binary
input and output. Every stack alphabet, the control state space, and the
set of instruction labels are finite. Running time counts machine steps.
Each instruction is a fixed finite sequence of elementary stack operations,
so this count differs from elementary operation count by a program-dependent
constant factor.

`RunsWithin alg x y T` means that execution on input $x$ terminates with
output $y$ within $T$ steps. We use mathlib's convention that the final
configuration has its initial control state, its output stack contains $y$,
and all other stacks are empty. Clearing work stacks costs at most a linear
overhead in the execution time plus input length.

# Formalization notes

The additional finiteness field covers **every** stack alphabet; the
underlying `FinTM2` bundle only requires finiteness of its input alphabet.
The runtime witness is the machine's actual execution, not an externally
assigned cost function. A single program is supplied to each approximation
predicate and therefore cannot depend on the instance or accuracy.
-/

namespace Lax213208.Programs

/-- A concrete binary-input, binary-output machine with finite alphabets. -/
structure Program extends Turing.TM2ComputableAux Bool Bool where
  finiteAlphabet : ∀ k, Fintype (tm.Γ k)

/-- Termination with the specified output in at most `T` machine steps. -/
def RunsWithin (alg : Program) (x y : List Bool) (T : ℕ) : Prop :=
  Nonempty (Turing.TM2OutputsInTime alg.tm
    (x.map alg.inputAlphabet.symm)
    (some (y.map alg.outputAlphabet.symm)) T)

end Lax213208.Programs
