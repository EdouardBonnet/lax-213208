import Lax213208.Approximation
import Lax213208.Programs
import Mathlib.Data.Real.Archimedean
import Lax560851.StructuralCombinators

/-!
---
title: Uniform approximation schemes
type: definition
---
An approximation scheme, for every real $\varepsilon>0$ and instance $x$,
returns a feasible solution with approximation ratio $1+\varepsilon$.
One program handles all accuracies. For maximization the symmetric ratio
convention gives $\mathrm{value}\ge\mathrm{OPT}/(1+\varepsilon)$, which
in particular is at least $(1-\varepsilon)\mathrm{OPT}$.

`ApproximatesWithin alg inputs ε T` requires the approximation guarantee
and termination within $T(n)$ RAM instructions on every instance of binary
size $n$ in the class. The same budget bounds the sufficient word length
in bits. Here $n$ measures only the instance, not the accuracy parameter.

# Formalization notes

A finite machine cannot receive an arbitrary real number exactly. We fix
the precision encoding $K(\varepsilon)=\max\{1,\lceil1/\varepsilon\rceil\}$
and supply the distinguished structural arena of the pair
$(K(\varepsilon),x)$, using the existing natural-number and product
presentation combinators. This requests enough
precision for error at most $\varepsilon$, since $1/K(\varepsilon)\le\varepsilon$.
The guarantee itself uses the real $\varepsilon$, and all scheme predicates
quantify over every positive real accuracy.

This encoding is a mathematical specification of the supplied finite input;
it does not assert an algorithm extracting an exact ceiling from an arbitrary
real oracle. The precision is an ordinary natural-number payload; it is
not a unary prefix. The input-fit condition in `RunsWithin` ensures that
this payload and the instance are representable at the stated word width.
Only positive $\varepsilon$ are used by the scheme predicates.
-/

namespace Lax213208.ApproximationScheme

open scoped NNReal

open OptimizationProblem Programs Approximation
open Lax560851.StructuralPresentation

universe u v

/-- Finite precision supplied to the machine for a requested real accuracy. -/
noncomputable def precision (ε : ℝ) : ℕ :=
  max 1 ⌈ε⁻¹⌉₊

/-- The existing structural product representation of precision and instance. -/
def schemeInput {α : Type u} (input : Presentation α) : Presentation (ℕ × α) :=
  Lax560851.StructuralCombinators.prod Lax560851.StructuralCombinators.nat input

def ApproximatesWithin {α : Type u} {β : Type v} {problem : Problem α β}
    (alg : Program) (inputs : InputClass α) (ε : ℝ) (T : ℕ → ℕ) : Prop :=
  ∀ x ∈ inputs, ∃ y,
    IsApproximation problem (1 + ε.toNNReal) x y ∧
    RunsWithin alg (schemeInput problem.input) problem.output
      (precision ε, x) y (T (inputSize problem x))

end Lax213208.ApproximationScheme
