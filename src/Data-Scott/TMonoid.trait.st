"
Monoid trait
"
Trait {
  #name : #TMonoid,
  #traits : 'TSemigroup',
  #classTraits : 'TSemigroup classTrait',
  #category : #'Data-Scott'
}

{ #category : #identity }
TMonoid classSide >> mempty [
	
  ^self explicitRequirement
]
