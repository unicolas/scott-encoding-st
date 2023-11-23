Class {
  #name : #ScottPairTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

ScottPairTest >> testFst [

  self assert: (ScottPair makePair: 1 with: $a) fst equals: 1
]

ScottPairTest >> testSnd [

    self assert: (ScottPair makePair: 1 with: $a) snd equals: $a
]
