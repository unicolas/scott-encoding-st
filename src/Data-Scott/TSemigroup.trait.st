"
Semigroup trait
"
Trait {
  #name : #TSemigroup,
  #category : #'Data-Scott'
}

{ #category : #'associative operations' }
TSemigroup >> <> a [
	
  ^self explicitRequirement
]
