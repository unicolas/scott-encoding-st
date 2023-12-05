Class {
  #name : #ScottMaybeTest,
  #superclass : #TestCase,
  #instVars: [
    'nothing',
    'j1',
    'j2'
  ],
  #category : #'Data-Scott-Tests'
}

{ #category : #running }
ScottMaybeTest >> setUp [

	super setUp.
	nothing := ScottMaybe makeNothing.
  j1 := ScottMaybe makeJust: 1.
  j2 := ScottMaybe makeJust: 2.
]

{ #category : #tests }
ScottMaybeTest >> testIsNothing [

  self
    assert: nothing isNothing;
    deny: j1 isNothing
]

{ #category : #tests }
ScottMaybeTest >> testIsJust [

  self
    assert: j1 isJust;
    deny: nothing isJust
]

{ #category : #tests }
ScottMaybeTest >> testfromJust [

  self
    assert: j1 fromJust equals: 1;
    should: [nothing fromJust] raise: Error
]

{ #category : #tests }
ScottMaybeTest >> testFromMaybe [

  self
    assert: (j1 fromMaybe: 2) equals: 1;
    assert: (nothing fromMaybe: 2) equals: 2
]

{ #category : #tests }
ScottMaybeTest >> testToList [

  self
    assert: nothing toList isNil;
    assert: j1 toList equals: (ScottList makeSingleton: 1)
]

{ #category : #tests }
ScottMaybeTest >> testFmap [

  self
    assert: (nothing fmap: [:x | x + 1]) isNothing;
    assert: (j1 fmap: [:x | x + 1]) equals: j2
]

{ #category : #tests }
ScottMaybeTest >> testMappend [

  | jl1 jl2 |
  jl1 := ScottMaybe makeJust: (ScottList makeSingleton: 1).
  jl2 := ScottMaybe makeJust: (ScottList makeSingleton: 2).
  jl12 := ScottMaybe makeJust: (
    ScottList makeCons: 1 with: (ScottList makeSingleton: 2)
  ).

  self
    assert: nothing <> nothing equals: nothing;
    assert: nothing <> jl1 equals: jl1;
    assert: jl1 <> nothing equals: jl1;
    assert: jl1 <> jl2 equals: jl12;
    assert: (nothing <> jl1) <> jl2 equals: jl12;
    assert: nothing <> (jl1 <> jl2) equals: jl12;
    assert: ScottMaybe mempty <> jl1 equals: jl1;
    assert: jl1 <> ScottMaybe mempty equals: jl1
]
