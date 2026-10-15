We define polynomial-time $r$-approximation algorithms and polynomial-time,
fully polynomial-time, efficient polynomial-time, and quasipolynomial-time
approximation schemes (PTAS, FPTAS, EPTAS, and QPTAS). Each notion is a
predicate on a fixed word-RAM program and a class of typed instances, relative to an
optimization problem with nonnegative objective values. Both minimization
and maximization are covered using approximation ratios at least one.

Schemes guarantee ratio $1+\varepsilon$ for every real $\varepsilon>0$,
with an explicit finite encoding of the requested precision.
Instances and solutions are mathematical objects, with fixed representations
using the archive's existing structural input and output conventions.
Programs may be obtained by compilation from a high-level implementation;
running times use the existing RAM execution semantics. Resource bounds
control both instruction count and sufficient word length in bits. The
quantifiers distinguish polynomial dependence on binary instance size,
arbitrary computable dependence on accuracy, and polynomial dependence on
both. This submission contains definitions only.
