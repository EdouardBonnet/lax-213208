import Lax213208.AlgorithmInput
import Lax213208.Programs
import Mathlib.Data.Nat.Log
import Mathlib.Data.Real.Archimedean

/-!
---
title: Running time
type: definition
---
`RunsInTime alg inputs T` asserts termination within $T(n)$ instructions,
where $n$ is the binary size of the instance. The bound also supplies a
sufficient word width in bits. It says nothing about solution quality.

Polynomial, quasipolynomial, and subexponential time are independent of
approximation ratios. Subexponential time means $2^{o(n)}$: for every
$\delta>0$, a bound $c\,2^{\lceil\delta n\rceil}$ holds.
-/

namespace Lax213208.RunningTime

open OptimizationProblem AlgorithmInput Programs

variable {Instance Solution : Type*} {problem : Problem Instance Solution}

def RunsInTime (alg : Program) (inputs : Set Instance) (time : ℕ → ℕ)
    (precision : Option ℕ := none) : Prop :=
  ∀ x ∈ inputs, ∃ output,
    RunsWithin alg (inputTape problem precision x) output (time (inputSize problem x))

def PolynomialTime (alg : Program) (inputs : Set Instance)
    (precision : Option ℕ := none) : Prop :=
  ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    RunsInTime (problem := problem) alg inputs (fun n => c * (n + 2) ^ d) precision

def QuasipolynomialTime (alg : Program) (inputs : Set Instance)
    (precision : Option ℕ := none) : Prop :=
  ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    RunsInTime (problem := problem) alg inputs
      (fun n => 2 ^ (c * (Nat.log2 (n + 2) + 1) ^ d)) precision

def SubexponentialTime (alg : Program) (inputs : Set Instance)
    (precision : Option ℕ := none) : Prop :=
  ∀ δ : ℝ, 0 < δ → ∃ c : ℕ, 0 < c ∧
    RunsInTime (problem := problem) alg inputs (fun n => c * 2 ^ ⌈δ * n⌉₊) precision

end Lax213208.RunningTime
