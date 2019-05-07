"
I represent a consecutive words that can be used at the beginning of sentences.

I am a key value in a Markov dictionary.

Collaborators:
- MgMarkovDictionaryGenerator: it uses me to generate the Markov dictionary
- MgMarkov: it uses me to generate randomized text

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
