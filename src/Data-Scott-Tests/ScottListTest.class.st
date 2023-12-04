Class {
  #name : #ScottListTest,
  #superclass : #TestCase,
  #instVars: [
    'emptyList',
    'listWith1',
    'listWith123'
  ],
  #category : #'Data-Scott-Tests'
}

{ #category : #running }
ScottListTest >> setUp [

	super setUp.
	emptyList := ScottList makeNil.
  listWith1 := ScottList makeSingleton: 1.
  listWith123 := ScottList 
    makeCons: 1 with: (ScottList 
      makeCons: 2 with: (ScottList 
        makeCons: 3 with: ScottList makeNil))
]

{ #category : #tests }
ScottListTest >> testHead [

  self
    assert: listWith1 head equals: 1;
    should: [emptyList head] raise: Error
]

{ #category : #tests }
ScottListTest >> testTail [

  self
    assert: listWith1 tail isNil;
    should: [emptyList tail] raise: Error
]

{ #category : #tests }
ScottListTest >> testFoldr [

  | append |
  append := [:each :acc | acc , each asString].

  self
    assert: (emptyList foldr: append into: '') equals: '';
    assert: (listWith1 foldr: append into: '') equals: '1';  
    assert: (listWith123 foldr: append into: '') equals: '321'
]

{ #category : #tests }
ScottListTest >> testFoldl [

  | append |
  append := [:acc :each | acc , each asString].

  self
    assert: (emptyList foldl: append into: '') equals: '';
    assert: (listWith1 foldl: append into: '') equals: '1';
    assert: (listWith123 foldl: append into: '') equals: '123'
]

{ #category : #tests }
ScottListTest >> testFixFoldr [

  | append |
  append := [:each :acc | acc , each asString].

  self
    assert: (emptyList fixFoldr: append into: '') equals: '';
    assert: (listWith1 fixFoldr: append into: '') equals: '1';
    assert: (listWith123 fixFoldr: append into: '') equals: '321'
]

{ #category : #tests }
ScottListTest >> testFixFoldl [

  | append |
  append := [:acc :each | acc , each asString].

  self
    assert: (emptyList fixFoldl: append into: '') equals: '';
    assert: (listWith1 fixFoldl: append into: '') equals: '1';
    assert: (listWith123 fixFoldl: append into: '') equals: '123'
]

{ #category : #tests }
ScottListTest >> testToMaybe [

  self
    assert: emptyList toMaybe isNothing; 
    assert: listWith123 toMaybe isJust;
    assert: listWith123 toMaybe fromJust equals: 1
]

{ #category : #tests }
ScottListTest >> testFilter [

  | listWith23 |
  listWith23 := ScottList makeCons: 2 with: (ScottList makeSingleton: 3).

  self 
    assert: (emptyList filter: [:x | x > 1]) isNil;
    assert: (listWith123 filter: [:x | x > 1]) equals: listWith23;
    assert: (listWith123 filter: [:x | x > 3]) isNil
]

{ #category : #tests }
ScottListTest >> testMap [

  | listWith234 |
  listWith234 := ScottList makeCons: 2 with: (
    ScottList makeCons: 3 with: (
      ScottList makeSingleton: 4
    )
  ).
  
  self
    assert: (emptyList map: [:x | x + 1]) isNil;
    assert: (listWith123 map: [:x | x + 1]) equals: listWith234
]

{ #category : #tests }
ScottListTest >> testAny [

  self
    deny: (emptyList any: [:x | x > 1]);
    assert: (listWith123 any: [:x | x > 1]);
    deny: (listWith123 any: [:x | x < 1])
]

{ #category : #tests }
ScottListTest >> testAll [

  self
    assert: (emptyList all: [:x | x > 1]);
    assert: (listWith123 all: [:x | x > 0]);
    deny: (listWith123 all: [:x | x > 1])
]
