import Lax213208.ApproximationScheme

/-!
---
title: Fully polynomial-time approximation schemes
type: definition
---
A program is a fully polynomial-time approximation scheme (FPTAS) on an
input class if it returns a $(1+1/k)$-approximation in time polynomial
in both the instance size $n$ and the inverse accuracy $k$.

There are positive integers $c,d,e$, independent of both $k$ and the
instance, bounding the running time by $c(n+2)^d(k+1)^e$ for every $k\ge1$.
This product form dominates any fixed polynomial in $n$ and $k$ with
nonnegative coefficients after enlarging the constants and exponents.
-/

namespace Lax213208.FPTAS

open OptimizationProblem Programs ApproximationScheme

def FPTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∃ c d e : ℕ, 0 < c ∧ 0 < d ∧ 0 < e ∧
    ∀ k : ℕ, 0 < k →
      ApproximatesWithin (problem := problem) alg inputs k
        (fun n => c * (n + 2) ^ d * (k + 1) ^ e)

end Lax213208.FPTAS
