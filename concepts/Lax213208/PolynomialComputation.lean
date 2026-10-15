import Lax213208.Programs
import Lax759944.BinaryWordEncoding

/-!
---
title: Polynomial-time maps
type: definition
---
A map is polynomial-time computable on a domain if one program returns its
encoded value within a polynomial resource bound in the encoded input size.
The encodings are fixed; no behavior is required outside the domain.
-/

namespace Lax213208.PolynomialComputation

open Programs Lax759944.BinaryWordEncoding

variable {Input Output : Type*}

def PolynomialTimeComputable (input : Input → List ℕ) (output : Output → List ℕ)
    (f : Input → Output) (domain : Set Input) : Prop :=
  ∃ alg : Program, ∃ c d : ℕ, 0 < c ∧ 0 < d ∧
    ∀ x ∈ domain,
      RunsWithin alg (input x) (output (f x)) (c * (bitSize (input x) + 2) ^ d)

end Lax213208.PolynomialComputation
