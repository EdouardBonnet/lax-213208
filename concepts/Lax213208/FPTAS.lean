import Lax213208.ApproximationScheme

/-!
---
title: Fully polynomial-time approximation schemes
type: definition
---
A program is a fully polynomial-time approximation scheme (FPTAS) on an
input class if, for every real $\varepsilon>0$, it returns a
$(1+\varepsilon)$-approximation in time polynomial in both the instance
size $n$ and $1/\varepsilon$.

There are positive integers $c,d,e$, independent of both $\varepsilon$ and
the instance, bounding the running time by
$c(n+2)^d(K(\varepsilon)+1)^e$, where
$K(\varepsilon)=\max\{1,\lceil1/\varepsilon\rceil\}$ is the supplied precision.
This natural-number bound is polynomial in $n$ and $1+1/\varepsilon$.
-/

namespace Lax213208.FPTAS

open OptimizationProblem Programs ApproximationScheme

def FPTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∃ c d e : ℕ, 0 < c ∧ 0 < d ∧ 0 < e ∧
    ∀ ε : ℝ, 0 < ε →
      ApproximatesWithin (problem := problem) alg inputs ε
        (fun n => c * (n + 2) ^ d * (precision ε + 1) ^ e)

end Lax213208.FPTAS
