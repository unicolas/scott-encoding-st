"
Scott-encoded Either
"
Class {
  #name : #ScottEither,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottEither class >> new [

  self error: 'Either should be created using makeLeft: or makeRight:'
]

{ #category : #'instance creation' }
ScottEither class >> makeLeft: a [
  "LEFT = λx l r. l x"

  ^self basicNew initialize: [:l :_ | l value: a]
]

{ #category : #'instance creation' }
ScottEither class >> makeRight: a [
  "RIGHT = λx l r. r x"

  ^self basicNew initialize: [:_ :r | r value: a]
]

{ #category : #'collection filtering' }
ScottEither class >> lefts: aListOfEither [
  "LEFTS = λl. FILTER ISLEFT l"

  ^aListOfEither filter: [:e | e isLeft]
]

{ #category : #'collection filtering' }
ScottEither class >> rights: aListOfEither [
  "RIGHTS = λl. FILTER ISRIGHT l"

  ^aListOfEither filter: [:e | e isRight]
]

{ #category : #'case analysis' }
ScottEither >> caseLeft: l caseRight: r [
  "EITHER = ID"

  ^(self id value: l value: r) value
]

{ #category : #testing }
ScottEither >> isLeft [
  "ISLEFT = λe. e TRUE FALSE"

  ^self caseLeft: [:_ | true] caseRight: [:_ | false]
]

{ #category : #testing }
ScottEither >> isRight [
  "ISRIGHT = λe. e FALSE TRUE"

  ^self isLeft not.
]

{ #category : #projecting }
ScottEither >> fromLeft: default [
  "FROMLEFT = λe d. e (λx. x) d"
  
  ^self caseLeft: [:l | l] caseRight: [:_ | default]
]

{ #category : #projecting }
ScottEither >> fromRight: default [
  "FROMRIGHT = λe d. e d (λx. x)"
  
  ^self caseLeft: [:_ | default] caseRight: [:r | r]
]

{ #category : #projecting }
ScottEither >> maybeLeft [
  "MAYBELEFT = λe. e (λx. JUST x) NOTHING"
  
  ^self
    caseLeft: [:l | ScottMaybe makeJust: l]
    caseRight: [:_ | ScottMaybe makeNothing]
]

{ #category : #projecting }
ScottEither >> maybeRight [
  "MAYBERIGHT = λe. e NOTHING (λx. JUST x)"
  
  ^self
    caseLeft: [:_ | ScottMaybe makeNothing]
    caseRight: [:r | ScottMaybe makeJust: r]
]

{ #category : #printing }
ScottEither >> printOn: aStream [

  self 
    caseLeft: [:l |
      aStream nextPutAll: 'Left '.
      l printOn: aStream
    ] 
    caseRight: [:r |
      aStream nextPutAll: 'Right '.
      r printOn: aStream
    ]
]
