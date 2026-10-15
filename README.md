# Approximation algorithms

Definitions-only submission `lax-213208`. Run `lax build .` to validate and
`lax serve .` to preview.

`Problem Instance Solution` specifies minimization or maximization,
feasibility, nonnegative objective values, and fixed representations.
Algorithms are existing word-RAM programs; input classes are `Set Instance`.

Correctness and running time are independent predicates on the same program:

```lean
open Lax213208.RApproximation Lax213208.RunningTime

-- Polynomial-time r-approximation:
Approximates (problem := P) alg inputs r ∧ PolynomialTime (problem := P) alg inputs

-- Subexponential-time r-approximation:
Approximates (problem := P) alg inputs r ∧ SubexponentialTime (problem := P) alg inputs
```

`Approximates` requires termination with an approximate solution, without
a time bound. `RunsInTime alg inputs T` supplies any desired bound. PTAS,
FPTAS, EPTAS, and QPTAS combine approximation and running-time guarantees
for every real `ε > 0`, with one program handling all accuracies.

Schemes use the same predicates with the optional argument `some ε`.
The finite input is the structural arena of `(max 1 ⌈ε⁻¹⌉₊, x)`;
the guarantee uses the real ratio `1 + ε`. Input size counts the binary
size of the instance arena. A resource bound controls instruction count
and sufficient word width; the output must agree at all larger widths.
Representations should use the archive's structural combinators or certified
constructor derivations. Complexity is relative to these fixed representations.

For high-level implementations, use [lax-62](https://laxarchive.org/lax-62/)
in the downstream proof package. Its compiled program has the required type:

```lean
open Lax213208.Programs Lax808846Proofs.Compile Lax808846Proofs.Imp

def algorithm (layout : Layout) (body : Com) : Program :=
  compileProgram layout body
```

`Lax62Proofs.Codegen.computesInTime_of_spec` turns a high-level specification
and cost proof into `ComputesInTime`, with instruction bound
`layout.const * K x + 1`. Combine this with the input-fit and word-width
bounds to establish `RunsWithin`, then the desired `RunsInTime` guarantee.

`LReduction` packages polynomial-time instance and solution maps, positive
constants, feasibility preservation, and the usual optimum and absolute-error
inequalities. Both optima must be attained. The solution map's input size
includes the original instance and the target solution.
