Class {
  #name : #ScottBooleanTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

ScottBooleanTest >> testAnd [

  self
    assert: (ScottBoolean makeFalse and: ScottBoolean makeFalse) isFalse;
    assert: (ScottBoolean makeFalse and: ScottBoolean makeTrue) isFalse;
    assert: (ScottBoolean makeTrue and: ScottBoolean makeFalse) isFalse;
    assert: (ScottBoolean makeTrue and: ScottBoolean makeTrue) isTrue
]

ScottBooleanTest >> testOr [

  self 
    assert: (ScottBoolean makeFalse or: ScottBoolean makeFalse) isFalse;
    assert: (ScottBoolean makeFalse or: ScottBoolean makeTrue) isTrue;
    assert: (ScottBoolean makeTrue or: ScottBoolean makeFalse) isTrue;
    assert: (ScottBoolean makeTrue or: ScottBoolean makeTrue) isTrue
]

ScottBooleanTest >> testNot [

  self
    assert: (ScottBoolean makeFalse not) isTrue;
    assert: (ScottBoolean makeTrue not) isFalse
]
