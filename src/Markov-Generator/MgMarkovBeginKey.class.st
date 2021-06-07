"
I identify a word sequences that can be used at the beginning of sentences.
I am used by {{gtClass:MgMarkovDictionaryGenerator}} at {{gtMethod:MgMarkovDictionaryGenerator>>#beginningKey}}.

In the following example, you can find me as a dictionary key with the same text as written in the {{gtMethod:MgMarkovBeginKey>>#printOn:|expanded=true}} {{gtExample:MgMarkovExamples>>#generatedDictionary|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #MgMarkovBeginKey,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Markov-Generator'
}

{ #category : #cleanup }
MgMarkovBeginKey class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
MgMarkovBeginKey class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
MgMarkovBeginKey class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #printing }
MgMarkovBeginKey >> printOn: aStream [
	aStream nextPutAll: 'SENTENCE BEGINNINGS'
]
