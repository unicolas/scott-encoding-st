"
Scott-encoded Maybe
"
Class {
  #name : #ScottMaybe,
  #superclass : #ScottData,
  #traits : 'TFunctor + TMonoid',
  #classTraits : 'TFunctor classTrait + TMonoid classTrait',
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottMaybe class >> new [

  self error: 'Maybe should be created using makeNothing or makeJust:'
]

{ #category : #'instance creation' }
ScottMaybe class >> makeNothing [
  "NOTHING = λn j. n"

  ^self basicNew initialize: [:n :_ | n]
]

{ #category : #'instance creation' }
ScottMaybe class >> makeJust: a [
  "JUST = λx n j. j x"

  ^self basicNew initialize: [:_ :j | j value: a]
]

{ #category : #'case analysis' }
ScottMaybe >> caseNothing: n caseJust: j [
  "MAYBE = ID"

  ^(self id value: n value: j) value
]

{ #category : #testing }
ScottMaybe >> isNothing [
  "ISNOTHING = λm. m TRUE FALSE"

  ^self caseNothing: [true] caseJust: [:_ | false]
]

{ #category : #testing }
ScottMaybe >> isJust [
  "ISNOTHING = λm. m FALSE TRUE"

  ^self isNothing not.
]

{ #category : #projecting }
ScottMaybe >> fromJust [
  "FROMJUST = λm. m ⊥ (λx. x)"

  ^self 
    caseNothing: [self error: 'fromJust called on Nothing']
    caseJust: [:j | j]
]

{ #category : #projecting }
ScottMaybe >> fromMaybe: default [
  "FROMMAYBE = λm d. m d (λx. x)"
  
  ^self caseNothing: [default] caseJust: [:j | j]
]

{ #category : #converting }
ScottMaybe >> toList [
  "TOLIST = λm. m NIL (λx. SINGLETON x)"

  ^self
    caseNothing: [ScottList makeNil]
    caseJust: [:x | ScottList makeSingleton: x]
]

{ #category : #printing }
ScottMaybe >> printOn: aStream [
  
  self 
    caseNothing: [aStream nextPutAll: 'Nothing'] 
    caseJust: [:j |
      aStream nextPutAll: 'Just '.
      j printOn: aStream
    ]
]

{ #category : #mapping }
ScottMaybe >> fmap: f [

  ^self
    caseNothing: [self class makeNothing]
    caseJust: [:j | self class makeJust: (f value: j)]
]

{ #category : #comparing }
ScottMaybe >> = m [

  ^self
    caseNothing: [
      m caseNothing: [true] caseJust: [:_ | false]
    ]
    caseJust: [:x1 |
      m caseNothing: [false] caseJust: [:x2 | x1 = x2]
    ]
]

{ #category : #'associative operations' }
ScottMaybe >> <> a [
  
  ^self
    caseNothing: [a]
    caseJust: [:j1 |
      a
        caseNothing: [self]
        caseJust: [:j2 | self class makeJust: j1 <> j2]
    ]
]

{ #category : #identity }
ScottMaybe class >> mempty [
  
  ^self makeNothing
]
