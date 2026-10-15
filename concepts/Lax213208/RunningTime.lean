import Lax213208.AlgorithmInput
import Lax213208.Programs
import Mathlib.Data.Nat.Log

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
    (accuracy : Option ℝ := none) : Prop :=
  ∀ x ∈ inputs, ∃ output,
    RunsWithin alg (inputTape problem accuracy x) output (time (inputSize problem x))

def PolynomialTime (alg : Program) (inputs : Set Instance)
    (accuracy : Option ℝ := none) : Prop :=
  ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    RunsInTime (problem := problem) alg inputs (fun n => c * (n + 2) ^ d) accuracy

def QuasipolynomialTime (alg : Program) (inputs : Set Instance)
    (accuracy : Option ℝ := none) : Prop :=
  ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    RunsInTime (problem := problem) alg inputs
      (fun n => 2 ^ (c * (Nat.log2 (n + 2) + 1) ^ d)) accuracy

def SubexponentialTime (alg : Program) (inputs : Set Instance)
    (accuracy : Option ℝ := none) : Prop :=
  ∀ δ : ℝ, 0 < δ → ∃ c : ℕ, 0 < c ∧
    RunsInTime (problem := problem) alg inputs (fun n => c * 2 ^ ⌈δ * n⌉₊) accuracy

end Lax213208.RunningTime
