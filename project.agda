module project where

data Bool : Set where
  true  : Bool
  false : Bool

not : Bool → Bool
not true = false
not false = true

_∧_ : Bool → Bool → Bool
true ∧ b = b
false ∧ b = false

_∨_ : Bool → Bool → Bool
true ∨ b = true
false ∨ b = b

data Maybe (A : Set) : Set where
  just : A → Maybe A
  nothing : Maybe A

data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ