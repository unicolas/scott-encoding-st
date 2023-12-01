"
Scott-encoded Boolean
"
Class {
  #name : #ScottBoolean,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

{ #category : #'instance creation' }
ScottBoolean class >> new [

  self error: 'Boolean should be created using makeTrue or makeFalse'
]

{ #category : #'instance creation' }
ScottBoolean class >> makeTrue [
  "TRUE = λt f. t"

  ^self basicNew initialize: [:t :_ | t]
]

{ #category : #'instance creation' }
ScottBoolean class >> makeFalse [
  "FALSE = λt f. f"

  ^self basicNew initialize: [:_ :f | f]
]

{ #category : #'case analysis' }
ScottBoolean >> caseTrue: t caseFalse: f [
  "IF = ID"

  ^(self id value: t value: f) value
]

{ #category : #'logical operations' }
ScottBoolean >> and: b [
  "AND = λb x. b x FALSE"

  ^self 
    caseTrue: [b] 
    caseFalse: [self class makeFalse]
]

{ #category : #'logical operations' }
ScottBoolean >> or: b [
  "OR = λb x. b TRUE x"

  ^self
    caseTrue: [self class makeTrue] 
    caseFalse: [b]
]

{ #category : #'logical operations' }
ScottBoolean >> not [
  "NOT = λb. b FALSE TRUE"

  ^self
    caseTrue: [self class makeFalse]
    caseFalse: [self class makeTrue]
]

{ #category : #printing }
ScottBoolean >> printOn: aStream [
  
  aStream nextPutAll: (self caseTrue: ['True'] caseFalse: ['False'])
]

{ #category : #testing }
ScottBoolean >> isTrue [

  ^self
    caseTrue: [true]
    caseFalse: [false]
]

{ #category : #testing }
ScottBoolean >> isFalse [

  ^self isTrue not
]
