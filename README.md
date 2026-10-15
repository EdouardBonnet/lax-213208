# Approximation algorithms

Definitions-only submission `lax-213208`. Preview with `lax serve .` and
validate with `lax build .`.

The public predicates retain an explicit program and a typed input class:

```lean
PTAS (problem := P) alg inputs
FPTAS (problem := P) alg inputs
EPTAS (problem := P) alg inputs
QPTAS (problem := P) alg inputs
RApproximation (problem := P) alg inputs r
```

Here `P : Problem Instance Solution`, `inputs : Set Instance`, and `alg` has
the archive's existing type `Lax808846.Ram.Program`. The local `Program`
abbreviation is definitionally that same type. All four schemes quantify over
real `ε > 0` and require approximation ratio `1 + ε`.

Both fixed-ratio algorithms and schemes use the shared
`ApproximationAlgorithm.ApproximatesWithin` predicate. `RApproximation`
specializes it to ratio `r` with the instance as argument; `SchemeWithin`
specializes it to ratio `1 + ε` with the precision-and-instance pair as
argument. Correctness and runtime are defined once; only the ratio, input
convention, and asymptotic quantifiers differ.

## Developing the algorithm at a higher level

Use [lax-62](https://laxarchive.org/lax-62/) in the downstream **proof package**
to construct and analyse the algorithm using its refinement, imperative, and
cost interfaces. Its compiled output can be supplied directly to these
predicates. For example, the underlying structured-language compiler has the
following interface (names fully qualified here to distinguish the layers):

```lean
def compiledAlgorithm
    (layout : Lax808846Proofs.Compile.Layout)
    (body : Lax808846Proofs.Imp.Com) : Lax213208.Programs.Program :=
  Lax808846Proofs.Compile.compileProgram layout body
```

An algorithm developed in lax-62's imperative IR is embedded into this
structured language by its code-generation pipeline. Choose the body and
layout once, independently of the instance, accuracy, and word width.

The relevant final bridge is
`Lax62Proofs.Codegen.computesInTime_of_spec`. It takes a high-level `Spec`,
compilation and input-fit hypotheses, and a layout-fit hypothesis, and proves
`ComputesInTime` for `compileProgram layout body`. Its instruction bound is
`layout.const * K x + 1`, where `K` is the proved structured-program cost.
The final `1` accounts for the terminal instruction.

To establish one of this submission's predicates:

1. Prove that the mathematical output is feasible and has the required ratio.
2. Establish the high-level specification and cost of the chosen algorithm.
3. Use the compilation bridge to obtain the existing `ComputesInTime` judgment.
4. Bound the compiled instruction cost and a sufficient word width by the
   displayed polynomial or quasipolynomial budget. Unfolding `RunsWithin`
   then leaves the input-fit condition and that same `ComputesInTime` judgment
   on the singleton containing the encoded input. Enlarging a time bound
   requires only enlarging the bound on the execution witness.

No Turing-machine translation or second execution semantics is involved.
The submission adds no axiom asserting compiler correctness. It relies on
the downstream proof using the existing verified compilation theorems.

## Representations and resource bounds

Instances and solutions are typed mathematical objects. `Problem` fixes a
faithful input presentation from [lax-560851](https://laxarchive.org/lax-560851/)
and an injective solution encoding. Its presentation combinators and
certified constructor derivations provide reusable input representations.
Natural or Boolean solutions can use its one-word output conventions;
structured solutions can use its arena output convention.

A scheme receives the distinguished arena of the pair `(precision ε, x)`,
where `precision ε = max 1 ⌈ε⁻¹⌉₊`. The precision is a natural payload,
not a unary string. The approximation guarantee remains a statement about
the requested real `ε`. Instance size is the binary size of the arena of
`x` alone, using [lax-759944](https://laxarchive.org/lax-759944/)'s size convention.

`RunsWithin ... T` requires the input entries and length to fit at `T` bits
and the specified output to be returned in at most `T` instructions at
**every** word width at least `T`. Using a common bound for instruction count
and sufficient word bits simplifies the five complexity predicates:
separately derived bounds can be absorbed into one bound of the same family.
Neither arbitrarily wide words nor instance-dependent program choices can
supply unaccounted computational power.

The public runtime predicate ultimately refers to
`Lax808846.RamComputes.ComputesInTime`, keeping the implementation explicit.
Lax560851's `RamComputableWithinUsing` instead existentially chooses a program,
so using it directly would describe existence of an implementation rather
than the running time of the submitter's particular program. Lax62's program
languages live in a proof package, which concept packages cannot require.
These two facts determine the boundary used here: typed mathematical data
and existing RAM computation concepts in the definitions; high-level program
construction and cost proofs in downstream proof packages.
