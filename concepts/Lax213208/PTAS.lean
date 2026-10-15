import Lax213208.ApproximationScheme

/-!
---
title: Polynomial-time approximation schemes
type: definition
---
A program is a polynomial-time approximation scheme (PTAS) on an input
class if, for each fixed real accuracy $\varepsilon>0$, it returns a
$(1+\varepsilon)$-approximation in time polynomial in the instance size.

For every positive real $\varepsilon$ there are positive integers $c,d$ bounding the
running time on every $n$-bit instance by $c(n+2)^d$.
Both constants may depend on $\varepsilon$; neither may depend on the instance.
The program is fixed before $\varepsilon$ is chosen. The shift by two includes
empty inputs. The optimization problem is an implicit parameter:
`PTAS (problem := P) alg inputs`.
-/

namespace Lax213208.PTAS

open OptimizationProblem Programs ApproximationScheme

def PTAS {problem : Problem} (alg : Program) (inputs : InputClass) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ApproximatesWithin (problem := problem) alg inputs ε
      (fun n => c * (n + 2) ^ d)

end Lax213208.PTAS
