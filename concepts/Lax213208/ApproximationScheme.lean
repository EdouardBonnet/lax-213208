import Lax213208.Approximation
import Lax213208.Programs

/-!
---
title: Uniform approximation schemes
type: definition
---
An approximation scheme receives an instance $x$ and a positive integer
$k$, and returns a feasible solution with approximation ratio $1+1/k$.
One program handles all accuracies. The physical input is $1^k0x$:
the unary encoding of $k$, a zero delimiter, then the instance bits.

Integer accuracy suffices to request arbitrarily small relative error:
given $\varepsilon>0$, choose
$k\ge\max\{1,\lceil1/\varepsilon\rceil\}$.
For maximization the symmetric ratio convention gives
$\mathrm{value}\ge\mathrm{OPT}/(1+1/k)$, which is at least
$(1-1/k)\mathrm{OPT}$.

`ApproximatesWithin alg inputs k T` requires the approximation guarantee
and termination within $T(n)$ steps on every $n$-bit instance in the class.
Here $n$ counts only the instance; running time includes processing the
accuracy prefix. Unary accuracy is compatible with polynomial dependence
on $k$ for FPTAS and arbitrary dependence on $k$ for the other schemes.
Only positive $k$ are used by the scheme predicates.
-/

namespace Lax213208.ApproximationScheme

open scoped NNReal

open OptimizationProblem Programs Approximation

def encodeInput (k : ℕ) (x : List Bool) : List Bool :=
  List.replicate k true ++ (false :: x)

def ApproximatesWithin {problem : Problem} (alg : Program)
    (inputs : InputClass) (k : ℕ) (T : ℕ → ℕ) : Prop :=
  ∀ x ∈ inputs, ∃ y,
    IsApproximation problem (1 + (k : ℝ≥0)⁻¹) x y ∧
    RunsWithin alg (encodeInput k x) y (T x.length)

end Lax213208.ApproximationScheme
