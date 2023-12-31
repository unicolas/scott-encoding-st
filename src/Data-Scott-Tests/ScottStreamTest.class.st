Class {
  #name : #ScottStreamTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

{ #category : #tests }
ScottStreamTest >> testIterate [

  | stream |
  stream := ScottStream iterate: [:x | x] from: 5.
  self
    assert: stream head equals: 5;
    assert: stream tail head equals: 5;
    assert: stream tail tail head equals: 5.

  stream := ScottStream iterate: [:x | x + 1] from: 1.
  self
    assert: stream head equals: 1;
    assert: stream tail head equals: 2;
    assert: stream tail tail head equals: 3;
    assert: stream tail tail tail head equals: 4.
]

{ #category : #tests }
ScottStreamTest >> testTake [

  | stream append |
  stream := ScottStream iterate: [:x | x + 1] from: 1.
  append := [:acc :each | acc , each asString].

  self
    assert: ((stream take: 0) foldl: append into: '') equals: '';
    assert: ((stream take: 1) foldl: append into: '') equals: '1';
    assert: ((stream take: 5) foldl: append into: '') equals: '12345'.
]

{ #category : #tests }
ScottStreamTest >> testInterleave [

  | stream append |
  stream := (ScottStream iterate: [:x | x + 1] from: 1)
    interleave:
      (ScottStream iterate: [:x | x] from: 0).
  append := [:acc :each | acc , each asString].

  self assert: ((stream take: 10) foldl: append into: '') equals: '1020304050'.
]

{ #category : #tests }
ScottStreamTest >> testFixInterleave [

  | stream append |
  stream := (ScottStream fixIterate: [:x | x + 1] from: 1)
    fixInterleave:
      (ScottStream fixIterate: [:x | x] from: 0).
  append := [:acc :each | acc , each asString].

  self assert: ((stream take: 10) foldl: append into: '') equals: '1020304050'.
]

{ #category : #tests }
ScottStreamTest >> testDrop [

  | stream |
  stream := ScottStream iterate: [:x | x + 1] from: 1.

  self
    assert: (stream drop: 10) head equals: 11;
    assert: (stream drop: 10) tail head equals: 12.
]

{ #category : #tests }
ScottStreamTest >> testRepeat [

  | stream |
  stream := ScottStream repeat: $X.
  self
    assert: stream head equals: $X;
    assert: stream tail head equals: $X;
    assert: stream tail tail head equals: $X;
    assert: stream tail tail tail head equals: $X.
]

{ #category : #tests }
ScottStreamTest >> testMap [

  | stream succ append |
  succ := [:x | x + 1].
  append := [:acc :each | acc , each asString].
  stream := (ScottStream iterate: succ from: 1) fmap: succ.
  
  self assert: ((stream take: 5) foldl: append into: '') equals: '23456'
]
