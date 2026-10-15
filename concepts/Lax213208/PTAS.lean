import Lax213208.ApproximationScheme

/-!
---
title: Polynomial-time approximation schemes
type: definition
---
A program is a polynomial-time approximation scheme (PTAS) on an input
class if, for each fixed accuracy $k\ge1$, it returns a
$(1+1/k)$-approximation in time polynomial in the instance size.

For every positive $k$ there are positive integers $c,d$ bounding the
running time on every $n$-bit instance by $c(n+2)^d$.
Both constants may depend on $k$; neither may depend on the instance.
The program is fixed before $k$ is chosen. The shift by two includes
empty inputs. The optimization problem is an implicit parameter:
`PTAS (problem := P) alg inputs`.
-/

namespace Lax213208.PTAS

open OptimizationProblem Programs ApproximationScheme

def PTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∀ k : ℕ, 0 < k → ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ApproximatesWithin (problem := problem) alg inputs k
      (fun n => c * (n + 2) ^ d)

end Lax213208.PTAS
