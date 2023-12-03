"
Scott-encoded Pair
"
Class {
  #name : #ScottPair,
  #superclass : #ScottData,
  #traits : 'TFunctor',
  #classTraits : 'TFunctor classTrait',
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottPair class >> new [

  self error: 'Pair should be created using makePair:with:'
]

{ #category : #'instance creation' }
ScottPair class >> makePair: fst with: snd [
  "PAIR = λa b p. p a b"

  ^self basicNew initialize: [:p | p value: fst value: snd]
]

{ #category : #projecting }
ScottPair >> fst [
  "FST = λp. p (λa b. a)"

  ^self id value: [:fst :_ | fst]
]

{ #category : #projecting }
ScottPair >> snd [
  "SND = λp. p (λa b. b)"
  
  ^self id value: [:_ :snd | snd]
]

{ #category : #printing }
ScottPair >> printOn: aStream [

  aStream nextPut: $(.
  self fst printOn: aStream.
  aStream nextPutAll: ', '.
  self snd printOn: aStream.
  aStream nextPut: $).
]

{ #category : #mapping }
ScottPair >> fmap: f [

  ^self class makePair: self fst with: (f value: self snd)
]
