Class {
  #name : #ScottEitherTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

{ #category : #tests }
ScottEitherTest >> testIsLeft [

  self
    assert: (ScottEither makeLeft: 1) isLeft;
    deny: (ScottEither makeRight: 1) isLeft
]

{ #category : #tests }
ScottEitherTest >> testIsRight [

  self
    deny: (ScottEither makeLeft: 1) isRight;
    assert: (ScottEither makeRight: 1) isRight
]

{ #category : #tests }
ScottEitherTest >> testFromLeft [

  self
    assert: ((ScottEither makeLeft: 1) fromLeft: 2) = 1;
    assert: ((ScottEither makeRight: 1) fromLeft: 2) = 2
]

{ #category : #tests }
ScottEitherTest >> testFromRight [

  self
    assert: ((ScottEither makeLeft: 1) fromRight: 2) = 2;
    assert: ((ScottEither makeRight: 1) fromRight: 2) = 1
]

{ #category : #tests }
ScottEitherTest >> testMaybeLeft [

  self
    assert: (ScottEither makeLeft: 1) maybeLeft fromJust = 1;
    assert: (ScottEither makeRight: 1) maybeLeft isNothing
]

{ #category : #tests }
ScottEitherTest >> testMaybeRight [

  self
    assert: (ScottEither makeLeft: 1) maybeRight isNothing;
    assert: (ScottEither makeRight: 1) maybeRight fromJust = 1
]

{ #category : #tests }
ScottEitherTest >> testFmap [

  self
    assert: ((ScottEither makeLeft: 1) fmap: [:x | x + 1]) maybeLeft fromJust 
      equals: 1;
    assert: ((ScottEither makeRight: 1) fmap: [:x | x + 1]) maybeRight fromJust 
      equals: 2
]
