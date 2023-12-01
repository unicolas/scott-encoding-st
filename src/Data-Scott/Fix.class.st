"
Fixed points
"
Class {
  #name : #Fix,
  #superclass : #Object,
  #category : #'Data-Scott'
}

{ #category : #'recursing' }
Fix class >> rec: f [
  "Y″ = λf. (λx. x x) (λx. f (λz. x x z))"

  ^[:x | (x value: x)] value: [:x | f value: [:z | (x value: x) value: z]]
]

{ #category : #'recursing' }
Fix class >> rec2: f [
  "Y″ = λf. (λx. x x) (λx. f (λz1 z2. x x z1 z2))"

  ^[:x | (x value: x)]
    value:
  [:x | f value: [:z1 :z2 | (x value: x) value: z1 value: z2]]
]

{ #category : #'recursing' }
Fix class >> rec3: f [
  "Y″ = λf. (λx. x x) (λx. f (λz1 z2 z3. x x z1 z2 z3))"

  ^[:x | (x value: x)]
    value:
  [:x | f value: [:z1 :z2 :z3 | (x value: x) value: z1 value: z2 value: z3]]
]
