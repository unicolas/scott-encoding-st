Class {
  #name : #ScottMaybeTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

{ #category : #tests }
ScottMaybeTest >> testIsNothing [

  self assert: ScottMaybe makeNothing isNothing
]

{ #category : #tests }
ScottMaybeTest >> testIsJust [

  self assert: (ScottMaybe makeJust: 1) isJust
]

{ #category : #tests }
ScottMaybeTest >> testfromJust [

  self
    assert: (ScottMaybe makeJust: 1) fromJust equals: 1;
    should: [ScottMaybe makeNothing fromJust] raise: Error
]

{ #category : #tests }
ScottMaybeTest >> testFromMaybe [

  self
    assert: ((ScottMaybe makeJust: 1) fromMaybe: 2) equals: 1;
    assert: ((ScottMaybe makeNothing) fromMaybe: 2) equals: 2
]

{ #category : #tests }
ScottMaybeTest >> testToList [

  self
    assert: (ScottMaybe makeNothing) toList isNil;
    deny: (ScottMaybe makeJust: 1) toList isNil;
    assert: (ScottMaybe makeJust: 1) toList tail isNil;
    assert: (ScottMaybe makeJust: 1) toList head equals: 1
]

{ #category : #tests }
ScottMaybeTest >> testFmap [

  self
    assert: (ScottMaybe makeNothing fmap: [:x | x + 1]) isNothing;
    assert: ((ScottMaybe makeJust: 1) fmap: [:x | x + 1]) 
      equals: (ScottMaybe makeJust: 2)
]
