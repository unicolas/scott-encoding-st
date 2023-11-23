Class {
  #name : #ScottListTest,
  #superclass : #TestCase,
  #category : #'Data-Scott-Tests'
}

ScottListTest >> testHead [

  self
    assert: (ScottList makeCons: 1 with: ScottList makeNil) head = 1;
    should: [ScottList makeNil head] raise: Error
]

ScottListTest >> testTail [

  self
    assert: (ScottList makeCons: 1 with: ScottList makeNil) tail isNil;
    should: [ScottList makeNil tail] raise: Error
]

ScottListTest >> testFoldr [

  | list append |
  append := [:each :acc | acc , each asString].

  list := ScottList makeNil.
  self assert: (list foldr: append into: '') equals: ''.

  list := ScottList makeCons: 3 with: ScottList makeNil.
  self assert: (list foldr: append into: '') equals: '3'.
  
  list := ScottList 
    makeCons: 1 with: (ScottList 
      makeCons: 2 with: (ScottList 
        makeCons: 3 with: ScottList makeNil)).
  self assert: (list foldr: append into: '') equals: '321'
]

ScottListTest >> testFoldl [

  | list append |
  append := [:acc :each | acc , each asString].

  list := ScottList makeNil.
  self assert: (list foldl: append into: '') equals: ''.

  list := ScottList makeCons: 3 with: ScottList makeNil.
  self assert: (list foldl: append into: '') equals: '3'.
  
  list := ScottList 
    makeCons: 1 with: (ScottList 
      makeCons: 2 with: (ScottList 
        makeCons: 3 with: ScottList makeNil)).
  self assert: (list foldl: append into: '') equals: '123'.
]

ScottListTest >> testFixFoldr [

  | list append |
  append := [:each :acc | acc , each asString].

  list := ScottList makeNil.
  self assert: (list fixFoldr: append into: '') equals: ''.

  list := ScottList makeCons: 3 with: ScottList makeNil.
  self assert: (list fixFoldr: append into: '') equals: '3'.
  
  list := ScottList 
    makeCons: 1 with: (ScottList 
      makeCons: 2 with: (ScottList 
        makeCons: 3 with: ScottList makeNil)).
  self assert: (list fixFoldr: append into: '') equals: '321'
]

ScottListTest >> testFixFoldl [

  | list append |
  append := [:acc :each | acc , each asString].

  list := ScottList makeNil.
  self assert: (list fixFoldl: append into: '') equals: ''.

  list := ScottList makeCons: 3 with: ScottList makeNil.
  self assert: (list fixFoldl: append into: '') equals: '3'.
  
  list := ScottList 
    makeCons: 1 with: (ScottList 
      makeCons: 2 with: (ScottList 
        makeCons: 3 with: ScottList makeNil)).
  self assert: (list fixFoldl: append into: '') equals: '123'.
]
