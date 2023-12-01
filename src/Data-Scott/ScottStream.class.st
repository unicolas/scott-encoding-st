"
Scott-encoded Stream
"
Class {
  #name : #ScottStream,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottStream class >> new [

  self error: 'Stream should be created using makeSCons:with:'
]

{ #category : #'instance creation' }
ScottStream class >> makeSCons: h with: t [
  "SCONS = λh t c. c h t"

  ^self basicNew initialize: [:c | c value: h value: t]
]

{ #category : #projecting }
ScottStream >> head [
  "HEAD = λs. s (λh t. h)"

  ^self id value: [:h :_ | h]
]

{ #category : #projecting }
ScottStream >> tail [
  "TAIL = λs. s (λh t. t (λa. a))"

  ^self id value: [:_ :t | t value: [:force | force]]
]

{ #category : #producing }
ScottStream class >> iterate: f from: a [
  "ITERATE = λf a. SCONS a (λd. d (ITERATE f (f a)))"

  ^ScottStream makeSCons: a with: [:delay |
    delay value: (ScottStream iterate: f from: (f value: a))
  ]
]

{ #category : #producing }
ScottStream class >> fixIterate: f from: a [
  "ITERATE′ = Y″ (λi f a. SCONS a (λd. d (i f (f a))))"

  ^(Fix rec2: [:iterate |
    [:f1 :a1 |
      ScottStream makeSCons: a1 with: [:delay |
        delay value: (iterate value: f1 value: (f1 value: a1))
      ]
    ]
  ]) value: f value: a
]

{ #category : #consuming }
ScottStream >> take: n [
  
  ^(n < 1)
    ifTrue: [ScottList makeNil]
    ifFalse: [ScottList makeCons: self head with: (self tail take: n - 1)]
]

{ #category : #combining }
ScottStream >> interleave: s [
  "INTERLEAVE = λs1 s2. SCONS (HEAD s1) (λd. d (INTERLEAVE s2 (TAIL s1)))"

  ^ScottStream makeSCons: self head with: [:delay |
    delay value: (s interleave: self tail)
  ]
]

{ #category : #combining }
ScottStream >> fixInterleave: s [
  "INTERLEAVE′ = Y″ (λi s1 s2. SCONS (HEAD s1) (λd. d (i s2 (TAIL s1))))"

  ^(Fix rec2: [:interleave |
    [:s1 :s2 |
      ScottStream makeSCons: s1 head with: [:delay |
        delay value: (interleave value: s2 value: s1 tail)
      ]
    ]
  ]) value: self value: s
]
