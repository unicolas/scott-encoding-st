"
Scott-encoded List
"
Class {
  #name : #ScottList,
  #superclass : #ScottData,
  #traits : 'TFunctor',
  #classTraits : 'TFunctor classTrait',
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottList class >> new [

  self error: 'List should be created using makeNil or makeCons:with:'
]

{ #category : #'instance creation' }
ScottList class >> makeNil [
  "NIL = λn c. n"

  ^self basicNew initialize: [:n :_ | n]
]

{ #category : #'instance creation' }
ScottList class >> makeCons: h with: t [
  "CONS = λh t n c. c h t"

  ^self basicNew initialize: [:_ :c | c value: h value: t]
]

{ #category : #'instance creation' }
ScottList class >> makeSingleton: h [
  "SINGLETON = λh. CONS h NIL"

  ^self makeCons: h with: self makeNil
]

{ #category : #'case analysis' }
ScottList >> caseNil: n caseCons: c [
  "MATCH = ID"

  ^(self id value: n value: c) value
]

{ #category : #projecting }
ScottList >> head [
  "HEAD = λl. l ⊥ (λh t. h)"

  ^self
    caseNil: [self error: 'head called on Nil']
    caseCons: [:h :_ | h]
]

{ #category : #projecting }
ScottList >> tail [
  "TAIL = λl. l ⊥ (λh t. t)"

  ^self
    caseNil: [self error: 'tail called on Nil']
    caseCons: [:_ :t | t]
]

{ #category : #reducing }
ScottList >> foldr: f into: a [
  "FOLDR = λf a l. l a (λh t. f h (FOLDR f a t))"

  ^self 
    caseNil: [a]
    caseCons: [:h :t | f value: h value: (t foldr: f into: a)]
]

{ #category : #reducing }
ScottList >> foldl: f into: a [
  "FOLDL = λf a l. l a (λh t. FOLDL f (f a h) t)"

  ^self 
    caseNil: [a]
    caseCons: [:h :t | t foldl: f into: (f value: a value: h)]
]

{ #category : #reducing }
ScottList >> fixFoldr: f into: a [
  "FOLDR′ = Y″ (λr f a l. l a (λh t. f h (r f a t)))"

  ^(Fix rec3: [:foldr |
    [:f1 :l :a1 |
      l caseNil: [a1] 
        caseCons: [:h :t |
          f1 value: h value: (foldr value: f1 value: t value: a1)
        ]
    ]
  ]) value: f value: self value: a
]

{ #category : #reducing }
ScottList >> fixFoldl: f into: a [
  "FOLDL′ = Y″ (λr f a l. l a (λh t. r f (f a h) t))"

  ^(Fix rec3: [:foldl |
    [:f1 :a1 :l |
      l caseNil: [a1] 
        caseCons: [:h :t |
          foldl value: f1 value: (f1 value: a1 value: h) value: t
        ]
    ]
  ]) value: f value: a value: self
]

{ #category : #testing }
ScottList >> isNil [
  "ISNIL = λl. l TRUE FALSE"

  ^self
    caseNil: [true]
    caseCons: [:_ :__ | false]
]

{ #category : #testing }
ScottList >> any: p [
  "ANY = λp l. l FALSE (λh t. IF (p h) TRUE (ANY p t))"

  ^self
    caseNil: [false]
    caseCons: [:h :t | (p value: h) ifTrue: [true] ifFalse: [t any: p]]
]

{ #category : #testing }
ScottList >> all: p [
  "ALL = λp l. l TRUE (λh t. IF (p h) (ALL p t) FALSE)"

  ^self
    caseNil: [true]
    caseCons: [:h :t | (p value: h) ifTrue: [t all: p] ifFalse: [false]]
]

{ #category : #filtering }
ScottList >> filter: f [
  "FILTER = λf l. l NIL (λh t. IF (f h) (CONS h (FILTER f t)) (FILTER f t))"

  ^self
    caseNil: [self class makeNil]
    caseCons: [:h :t |
      (f value: h)
        ifTrue: [self class makeCons: h with: (t filter: f)]
        ifFalse: [t filter: f]
    ]
]

{ #category : #converting }
ScottList >> toMaybe [
  "TOMAYBE = λl. l NOTHING (λh t. JUST h)"

  ^self
    caseNil: [ScottMaybe makeNothing]
    caseCons: [:h :_ | ScottMaybe makeJust: h]
]

{ #category : #printing }
ScottList >> printOn: aStream [
  
  aStream nextPut: $[.
  self
    caseNil: []
    caseCons: [:h :t |
      aStream print: h.
      t printPrepended: ', ' on: aStream
    ].
  aStream nextPut: $].
]

{ #category : #printing }
ScottList >> printPrepended: s on: aStream [

    self 
      caseNil: []
      caseCons: [:h :t |
        aStream nextPutAll: s.
        aStream print: h.
        t printPrepended: s on: aStream
      ]
]

{ #category : #transforming }
ScottList >> map: f [
  "MAP = λf l. l NIL (λh t. CONS (f h) (MAP f t))"

  ^self
    caseNil: [self class makeNil]
    caseCons: [:h :t | self class makeCons: (f value: h) with: (t map: f)]
]

{ #category : #mapping }
ScottList >> fmap: f [

  ^self map: f
]

{ #category : #comparing }
ScottList >> = l [

  ^self
    caseNil: [
      l caseNil: [true] caseCons: [false]
    ]
    caseCons: [:h1 :t1 |
      l caseNil: [false] caseCons: [:h2 :t2 | h1 = h2 and: [t1 = t2]]
    ]
]
