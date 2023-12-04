"
Functor trait
"
Trait {
  #name : #TFunctor,
  #category : #'Data-Scott'
}

{ #category : #mapping }
TFunctor >> fmap: f [

  ^self explicitRequirement
]

{ #category : #mapping }
TFunctor >> replace: a [

  ^self fmap: [:_ | a]
]
