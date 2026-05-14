module Project where

open import Data.Nat using (ℕ)

data Formula : Set where
  Var : ℕ → Formula
  Neg : Formula → Formula
  And : Formula → Formula → Formula
  Or  : Formula → Formula → Formula

data Literal : Set where
  Pos : ℕ → Literal
  NegLit : ℕ → Literal

data NNF : Set where
  Lit : Literal → NNF
  AndN : NNF → NNF → NNF
  OrN  : NNF → NNF → NNF

negNNF : NNF → NNF
negNNF (Lit (Pos n))    = Lit (NegLit n)
negNNF (Lit (NegLit n)) = Lit (Pos n)
negNNF (AndN p q)       = OrN  (negNNF p) (negNNF q)
negNNF (OrN  p q)       = AndN (negNNF p) (negNNF q)

to-nnf : Formula → NNF
to-nnf (Var n)      = Lit (Pos n)
to-nnf (Neg f)      = negNNF (to-nnf f)
to-nnf (And f g)    = AndN (to-nnf f) (to-nnf g)
to-nnf (Or f g)     = OrN  (to-nnf f) (to-nnf g)
