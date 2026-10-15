import Lax213208.Approximation
import Lax213208.Programs
import Mathlib.Data.Real.Archimedean

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
and termination within $T(n)$ steps on every $n$-bit instance in the class.
Here $n$ counts only the instance.

# Formalization notes

A finite machine cannot receive an arbitrary real number exactly. We fix
the precision encoding $K(\varepsilon)=\max\{1,\lceil1/\varepsilon\rceil\}$
and supply the binary string $1^{K(\varepsilon)}0x$. This requests enough
precision for error at most $\varepsilon$, since $1/K(\varepsilon)\le\varepsilon$.
The guarantee itself uses the real $\varepsilon$, and all scheme predicates
quantify over every positive real accuracy.

This encoding is a mathematical specification of the supplied finite input;
it does not assert an algorithm extracting an exact ceiling from an arbitrary
real oracle. Execution time includes reading the precision prefix. Its length
is $O(1+1/\varepsilon)$, consistent with FPTAS bounds. Only positive
$\varepsilon$ are used by the scheme predicates.
-/

namespace Lax213208.ApproximationScheme

open scoped NNReal

open OptimizationProblem Programs Approximation

/-- Finite precision supplied to the machine for a requested real accuracy. -/
noncomputable def precision (ε : ℝ) : ℕ :=
  max 1 ⌈ε⁻¹⌉₊

noncomputable def encodeInput (ε : ℝ) (x : List Bool) : List Bool :=
  List.replicate (precision ε) true ++ (false :: x)

def ApproximatesWithin {problem : Problem} (alg : Program)
    (inputs : InputClass) (ε : ℝ) (T : ℕ → ℕ) : Prop :=
  ∀ x ∈ inputs, ∃ y,
    IsApproximation problem (1 + ε.toNNReal) x y ∧
    RunsWithin alg (encodeInput ε x) y (T x.length)

end Lax213208.ApproximationScheme
