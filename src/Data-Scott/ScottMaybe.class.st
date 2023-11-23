"
Scott-encoded Maybe
"
Class {
  #name : #ScottMaybe,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

ScottMaybe class >> new [

  self error: 'Maybe should be created using makeNothing or makeJust:'
]

ScottMaybe class >> makeNothing [
  "NOTHING = λn j. n"

  ^self basicNew initialize: [:n :_ | n]
]

ScottMaybe class >> makeJust: a [
  "JUST = λx n j. j x"

  ^self basicNew initialize: [:_ :j | j value: a]
]

ScottMaybe >> caseNothing: n caseJust: j [
  "MAYBE = ID"

  ^(self id value: n value: j) value
]

ScottMaybe >> isNothing [
  "ISNOTHING = λm. m TRUE FALSE"

  ^self caseNothing: [true] caseJust: [:_ | false]
]

ScottMaybe >> isJust [
  "ISNOTHING = λm. m FALSE TRUE"

  ^self isNothing not.
]

ScottMaybe >> fromJust [
  "FROMJUST = λm. m ⊥ (λx. x)"

  ^self 
    caseNothing: [self error: 'fromJust called on Nothing']
    caseJust: [:j | j]
]

ScottMaybe >> fromMaybe: default [
  "FROMMAYBE = λm d. m d (λx. x)"
  
  ^self caseNothing: [default] caseJust: [:j | j]
]

ScottMaybe >> printOn: aStream [
  
  self 
    caseNothing: [aStream nextPutAll: 'Nothing'] 
    caseJust: [:j |
      aStream nextPutAll: 'Just '.
      j printOn: aStream
    ]
]
