Class {
  #name : #ScottEitherTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

ScottEitherTest >> testIsLeft [

  self
    assert: (ScottEither makeLeft: 1) isLeft;
    deny: (ScottEither makeRight: 1) isLeft
]

ScottEitherTest >> testIsRight [

  self
    deny: (ScottEither makeLeft: 1) isRight;
    assert: (ScottEither makeRight: 1) isRight
]

ScottEitherTest >> testFromLeft [

  self
    assert: ((ScottEither makeLeft: 1) fromLeft: 2) = 1;
    assert: ((ScottEither makeRight: 1) fromLeft: 2) = 2
]

ScottEitherTest >> testFromRight [

  self
    assert: ((ScottEither makeLeft: 1) fromRight: 2) = 2;
    assert: ((ScottEither makeRight: 1) fromRight: 2) = 1
]

ScottEitherTest >> testMaybeLeft [

  self
    assert: (ScottEither makeLeft: 1) maybeLeft fromJust = 1;
    assert: (ScottEither makeRight: 1) maybeLeft isNothing
]

ScottEitherTest >> testMaybeRight [

  self
    assert: (ScottEither makeLeft: 1) maybeRight isNothing;
    assert: (ScottEither makeRight: 1) maybeRight fromJust = 1
]
