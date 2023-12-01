"
Base class for Scott-encoded data
"
Class {
  #name : #ScottData,
  #superclass : #Object,
  #instVars : ['data'],
  #category : #'Data-Scott'
}

{ #category : #'class initialization' }
ScottData >> initialize: value [

  data := value.
  ^self
]

{ #category : #accessing }
ScottData >> id [

  ^data
]
