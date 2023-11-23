"
Scott-encoded Pair
"
Class {
  #name : #ScottPair,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

ScottPair class >> new [

  self error: 'Pair should be created using makePair:with:'
]

ScottPair class >> makePair: fst with: snd [
  "PAIR = λa b p. p a b"

  ^self basicNew initialize: [:p | p value: fst value: snd]
]

ScottPair >> fst [
  "FST = λp. p (λa b. a)"

  ^self id value: [:fst :_ | fst]
]

ScottPair >> snd [
  "SND = λp. p (λa b. b)"
  
  ^self id value: [:_ :snd | snd]
]

ScottPair >> printOn: aStream [

  aStream nextPut: $(.
  self fst printOn: aStream.
  aStream nextPutAll: ', '.
  self snd printOn: aStream.
  aStream nextPut: $).
]
