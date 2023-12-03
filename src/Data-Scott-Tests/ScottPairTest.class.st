Class {
  #name : #ScottPairTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

{ #category : #tests }
ScottPairTest >> testFst [

  self assert: (ScottPair makePair: 1 with: $a) fst equals: 1
]

{ #category : #tests }
ScottPairTest >> testSnd [

    self assert: (ScottPair makePair: 1 with: $a) snd equals: $a
]

{ #category : #tests }
ScottPairTest >> testFmap [

    | p |
    p := (ScottPair makePair: 1 with: 2) fmap: [:x | x + 1].
    self
      assert: p fst equals: 1;
      assert: p snd equals: 3
]
