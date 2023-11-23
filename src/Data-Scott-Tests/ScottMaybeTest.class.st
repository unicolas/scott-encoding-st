Class {
  #name : #ScottMaybeTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

ScottMaybeTest >> testIsNothing [

  self assert: ScottMaybe makeNothing isNothing
]

ScottMaybeTest >> testIsJust [

  self assert: (ScottMaybe makeJust: 1) isJust
]

ScottMaybeTest >> testfromJust [

  self
    assert: (ScottMaybe makeJust: 1) fromJust = 1;
    should: [ScottMaybe makeNothing fromJust] raise: Error
]

ScottMaybeTest >> testFromMaybe [

  self
    assert: ((ScottMaybe makeJust: 1) fromMaybe: 2) = 1;
    assert: ((ScottMaybe makeNothing) fromMaybe: 2) = 2
]
