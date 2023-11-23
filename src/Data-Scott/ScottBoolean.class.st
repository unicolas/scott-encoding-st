"
Scott-encoded Boolean
"
Class {
  #name : #ScottBoolean,
  #superclass : #ScottData,
  #category : #'Data-Scott'
}

ScottBoolean class >> new [

  self error: 'Boolean should be created using makeTrue or makeFalse'
]

ScottBoolean class >> makeTrue [
  "TRUE = λt f. t"

  ^self basicNew initialize: [:t :_ | t]
]

ScottBoolean class >> makeFalse [
  "FALSE = λt f. f"

  ^self basicNew initialize: [:_ :f | f]
]

ScottBoolean >> caseTrue: t caseFalse: f [
  "IF = ID"

  ^(self id value: t value: f) value
]

ScottBoolean >> and: b [
  "AND = λb x. b x FALSE"

  ^self 
    caseTrue: [b] 
    caseFalse: [self class makeFalse]
]

ScottBoolean >> or: b [
  "OR = λb x. b TRUE x"

  ^self
    caseTrue: [self class makeTrue] 
    caseFalse: [b]
]

ScottBoolean >> not [
  "NOT = λb. b FALSE TRUE"

  ^self
    caseTrue: [self class makeFalse]
    caseFalse: [self class makeTrue]
]

ScottBoolean >> printOn: aStream [
  
  aStream nextPutAll: (self caseTrue: ['True'] caseFalse: ['False'])
]

ScottBoolean >> isTrue [

  ^self
    caseTrue: [true]
    caseFalse: [false]
]

ScottBoolean >> isFalse [

  ^self isTrue not
]
