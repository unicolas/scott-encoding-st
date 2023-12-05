Class {
  #name : #ScottEitherTest,
  #superclass : #TestCase,
  #instVars: [
    'l1',
    'l2',
    'r1',
    'r2'
  ],
  #category : #'Data-Scott-Tests'
}

{ #category : #running }
ScottEitherTest >> setUp [

	super setUp.
	l1 := ScottEither makeLeft: 1.
  l2 := ScottEither makeLeft: 2.
  r1 := ScottEither makeRight: 1.
  r2 := ScottEither makeRight: 2.
]

{ #category : #tests }
ScottEitherTest >> testIsLeft [

  self
    assert: l1 isLeft;
    deny: r1 isLeft
]

{ #category : #tests }
ScottEitherTest >> testIsRight [

  self
    deny: l1 isRight;
    assert: r1 isRight
]

{ #category : #tests }
ScottEitherTest >> testFromLeft [

  self
    assert: (l1 fromLeft: 2) equals: 1;
    assert: (r1 fromLeft: 2) equals: 2
]

{ #category : #tests }
ScottEitherTest >> testFromRight [

  self
    assert: (l1 fromRight: 2) equals: 2;
    assert: (r1 fromRight: 2) equals: 1
]

{ #category : #tests }
ScottEitherTest >> testMaybeLeft [

  self
    assert: l1 maybeLeft fromJust equals: 1;
    assert: r1 maybeLeft isNothing
]

{ #category : #tests }
ScottEitherTest >> testMaybeRight [

  self
    assert: l1 maybeRight isNothing;
    assert: r1 maybeRight fromJust equals: 1
]

{ #category : #tests }
ScottEitherTest >> testFmap [

  self
    assert: (l1 fmap: [:x | x + 1]) equals: l1;
    assert: (r1 fmap: [:x | x + 1]) equals: r2
]

{ #category : #tests }
ScottEitherTest >> testMappend [

  self
    assert: l1 <> l2 equals: l2;
    assert: l2 <> l1 equals: l1;
    assert: l1 <> r1 equals: r1;
    assert: r1 <> l1 equals: r1;
    assert: r1 <> r2 equals: r1;
    assert: (l1 <> l2) <> r1 equals: l1 <> (l2 <> r1);
    assert: (r1 <> r2) <> l1 equals: r1 <> (r2 <> l1)
]
