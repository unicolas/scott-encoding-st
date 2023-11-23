"
Scott-encoded List
"
Class {
  #name : #ScottList,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

ScottList class >> new [

  self error: 'List should be created using makeNil or makeCons:with:'
]

ScottList class >> makeNil [
  "NIL = λn c. n"

  ^self basicNew initialize: [:n :_ | n]
]

ScottList class >> makeCons: h with: t [
  "CONS = λh t n c. c h t"

  ^self basicNew initialize: [:_ :c | c value: h value: t]
]

ScottList >> caseNil: n caseCons: c [
  "MATCH = ID"

  ^(self id value: n value: c) value
]

ScottList >> head [
  "HEAD = λl. l ⊥ (λh t. h)"

  ^self
    caseNil: [self error: 'head called on Nil']
    caseCons: [:h :_ | h]
]

ScottList >> tail [
  "TAIL = λl. l ⊥ (λh t. t)"

  ^self
    caseNil: [self error: 'tail called on Nil']
    caseCons: [:_ :t | t]
]

ScottList >> foldr: f into: a [
  "FOLDR = λf a l. l a (λh t. f h (FOLDR f a t))"

  ^self 
    caseNil: [a]
    caseCons: [:h :t | f value: h value: (t foldr: f into: a)]
]

ScottList >> foldl: f into: a [
  "FOLDL = λf a l. l a (λh t. FOLDL f (f a h) t)"

  ^self 
    caseNil: [a]
    caseCons: [:h :t | t foldl: f into: (f value: a value: h)]
]

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

ScottList >> isNil [

  ^self
    caseNil: [true]
    caseCons: [:_ :__ | false]
]

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

ScottList >> printPrepended: s on: aStream [

    self 
      caseNil: []
      caseCons: [:h :t |
        aStream nextPutAll: s.
        aStream print: h.
        t printPrepended: s on: aStream
      ]
]
