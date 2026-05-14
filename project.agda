module Project where

open import Data.Nat using (ℕ)

-- PROBLEM 1: Formula, ki vsebuje spremenljivke, negacije, konjunkcije in disjunkcije.
data Formula : Set where
  Var : ℕ → Formula
  Neg : Formula → Formula
  And : Formula → Formula → Formula
  Or  : Formula → Formula → Formula


-- PROBLEM 2: Literal, ki je lahko pozitivna ali negativna spremenljivka, in NNF formula, ki je lahko literal, konjunkcija ali disjunkcija NNF formul.
data Literal : Set where
  Pos : ℕ → Literal
  NegLit : ℕ → Literal

data NNF : Set where
  Lit : Literal → NNF
  AndN : NNF → NNF → NNF
  OrN  : NNF → NNF → NNF


-- PROBLEM 3: Pomozna funkcija, ki negira NNF formulo, in funkcija, ki pretvori formulo v NNF.
neg-nnf : NNF → NNF
neg-nnf (Lit (Pos n))    = Lit (NegLit n)
neg-nnf (Lit (NegLit n)) = Lit (Pos n)
neg-nnf (AndN p q)       = OrN  (neg-nnf p) (neg-nnf q)
neg-nnf (OrN  p q)       = AndN (neg-nnf p) (neg-nnf q)

to-nnf : Formula → NNF
to-nnf (Var n)      = Lit (Pos n)
to-nnf (Neg f)      = neg-nnf (to-nnf f)
to-nnf (And f g)    = AndN (to-nnf f) (to-nnf g)
to-nnf (Or f g)     = OrN  (to-nnf f) (to-nnf g)
