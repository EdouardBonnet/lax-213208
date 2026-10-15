import Lax213208.Approximation
import Lax213208.PolynomialComputation

/-!
---
title: L-reductions
type: definition
---
An L-reduction consists of polynomial-time instance and solution maps and
positive constants $a,b$. It maps valid instances and feasible solutions
to valid instances and feasible solutions, and satisfies
$\mathrm{OPT}_B(f(x))\le a\,\mathrm{OPT}_A(x)$ and
$|\mathrm{OPT}_A(x)-v_A(g(x,y))|
 \le b\,|\mathrm{OPT}_B(f(x))-v_B(y)|$.

Optima are required to be attained. The solution map receives both $x$
and $y$; its time is measured in their combined encoded size. Their word
lists are paired by prefixing the length of the first list.
-/

namespace Lax213208.LReduction

open OptimizationProblem Approximation PolynomialComputation

variable {SourceInstance SourceSolution TargetInstance TargetSolution : Type*}

def solutionMapInput (source : Problem SourceInstance SourceSolution)
    (target : Problem TargetInstance TargetSolution)
    (xy : SourceInstance × TargetSolution) : List ℕ :=
  let first := inputWords source xy.1
  first.length :: (first ++ target.output xy.2)

structure LReduction (source : Problem SourceInstance SourceSolution)
    (target : Problem TargetInstance TargetSolution)
    (sourceInputs : Set SourceInstance) (targetInputs : Set TargetInstance) where
  instanceMap : SourceInstance → TargetInstance
  solutionMap : SourceInstance → TargetSolution → SourceSolution
  optimumFactor : ℝ
  errorFactor : ℝ
  optimumFactor_pos : 0 < optimumFactor
  errorFactor_pos : 0 < errorFactor
  instanceMap_polytime :
    PolynomialTimeComputable (inputWords source) (inputWords target) instanceMap sourceInputs
  solutionMap_polytime :
    PolynomialTimeComputable (solutionMapInput source target) source.output
      (fun xy => solutionMap xy.1 xy.2)
      {xy | xy.1 ∈ sourceInputs ∧ target.feasible (instanceMap xy.1) xy.2}
  maps_instances : ∀ x ∈ sourceInputs, instanceMap x ∈ targetInputs
  maps_solutions : ∀ x ∈ sourceInputs, ∀ y, target.feasible (instanceMap x) y →
    source.feasible x (solutionMap x y)
  bounds : ∀ x ∈ sourceInputs, ∃ sourceOpt targetOpt : ℝ,
    IsOptimalValue source x sourceOpt ∧
    IsOptimalValue target (instanceMap x) targetOpt ∧
    targetOpt ≤ optimumFactor * sourceOpt ∧
    ∀ y, target.feasible (instanceMap x) y →
      |sourceOpt - source.value x (solutionMap x y)| ≤
        errorFactor * |targetOpt - target.value (instanceMap x) y|

end Lax213208.LReduction
