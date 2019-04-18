"
I keep collection of ${class:MgMarkovLinkedWords}$. I am used as a value in case of ${class:MgMarkovBeginKey}$ key.

Look for ${method:MgMarkovBeginKey>>#printOn:|expanded=true}$ key in the example below and explore its value.

Example: ${example:MgMarkovExamples>>#generatedDictionary|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #MgMarkovLinkedWordsCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Markov-Generator'
}

{ #category : #adding }
MgMarkovLinkedWordsCollection >> addLinkedWords: aSoMarkovLinkedWords [
	self collection addLast: aSoMarkovLinkedWords
]

{ #category : #accessing }
MgMarkovLinkedWordsCollection >> atRandom [
	<return: #MgMarkovLinkedWords>
	^ self collection atRandom
]

{ #category : #accessing }
MgMarkovLinkedWordsCollection >> collection [
	<return: #OrderedCollection>
	^ collection
]

{ #category : #accessing }
MgMarkovLinkedWordsCollection >> gtWordsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ (self collection gtItemsFor: aView)
			title: 'Words'
]

{ #category : #testing }
MgMarkovLinkedWordsCollection >> hasLinkedWords [
	<return: #Boolean>
	^ self numberOfLinkedWords isZero not
]

{ #category : #initialization }
MgMarkovLinkedWordsCollection >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #convenience }
MgMarkovLinkedWordsCollection >> numberOfLinkedWords [
	<return: #Integer>
	^ self collection ifNil: 0 ifNotNil: #size
]

{ #category : #printing }
MgMarkovLinkedWordsCollection >> printOn: aStream [
	| aMaxIterations |
	self hasLinkedWords ifFalse: [ super printOn: aStream. ^ self ].
	aStream
		print: self numberOfLinkedWords;
		space;
		nextPutAll: ('item' asPluralBasedOn: self numberOfLinkedWords);
		nextPutAll: ': '.
	aMaxIterations := (3 min: self numberOfLinkedWords).
	1 to: aMaxIterations do: [ :anIndex |
		aStream print: (self collection at: anIndex).
		anIndex = aMaxIterations ifFalse: [ aStream nextPutAll: ', ' ] ].
	self numberOfLinkedWords > 3
		ifTrue: [ aStream nextPutAll: '...' ]
]
