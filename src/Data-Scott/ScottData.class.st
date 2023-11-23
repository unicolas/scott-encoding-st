"
Base class for Scott-encoded data
"
Class {
  #name : #ScottData,
  #superclass : #Object,
  #instVars : ['data'],
  #category : #'Data-Scott'
}

ScottData >> initialize: value [

  data := value.
  ^self
]

ScottData >> id [

  ^data
]
