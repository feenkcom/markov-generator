"
I am a collection of words that can appear in a sentence one followed by the other. 
The number of words is defined by ${class:SoMarkovDictionaryGenerator}$ during the Markov dictionary generations, by ${method:SoMarkovDictionaryGenerator>>#order}$ value. 

I am used as a key in the Markov dictionary and also as the dictionary value in case of ${class:SoMarkovBeginKey}$ key as those values are special.

Example: ${example:SoMarkovExamples>>#generatedDictionary|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #MgMarkovLinkedWords,
	#superclass : #Object,
	#instVars : [
		'words'
	],
	#category : #'Markov-Generator'
}

{ #category : #comparing }
MgMarkovLinkedWords >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ words = anObject words
]

{ #category : #'instance creation' }
MgMarkovLinkedWords >> fromWord: aString [
	<return: #MgMarkovLinkedWords>
	| aCopy |
	aCopy := Array new: self numberOfWords.
	2 to: self numberOfWords do: [ :anIndex | 
		aCopy at: anIndex - 1 put: (self words at: anIndex) ].
	(aCopy at: self numberOfWords put: aString).
	^ self class new words: aCopy.
]

{ #category : #'gt-extension' }
MgMarkovLinkedWords >> gtWordsFor: aView [
	<gtView>
	self words ifNil: [ ^ aView empty ].
	^ (self words gtItemsFor: aView)
			title: 'Words'
]

{ #category : #testing }
MgMarkovLinkedWords >> hasWords [
	<return: #Boolean>
	^ self numberOfWords isZero not
]

{ #category : #comparing }
MgMarkovLinkedWords >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ words hash
]

{ #category : #convenience }
MgMarkovLinkedWords >> numberOfWords [
	<return: #Integer>
	^ self words ifNil: 0 ifNotNil: #size
]

{ #category : #printing }
MgMarkovLinkedWords >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	self hasWords ifFalse: [ super printOn: aStream. ^ self ].
	self words 
		do: [ :eachWord | aStream nextPutAll: eachWord asString ] 
		separatedBy: [ aStream nextPutAll: ' ' ]
]

{ #category : #accessing }
MgMarkovLinkedWords >> words [
	^ words
]

{ #category : #accessing }
MgMarkovLinkedWords >> words: aCollection [
	words := aCollection asArray
]
