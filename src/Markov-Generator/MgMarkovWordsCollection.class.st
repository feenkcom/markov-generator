"
I represent a collection of words that can appear in a sentence after a particular words sequence stored in Markov dictionary as keys.

Collaborators:
- MgMarkovDictionaryGenerator: generates my instances

Public API and Key Messages

- addWord:
- atRandom

Internal Representation and Key Implementation Points.

Instance Variables

- collection: OrderedCollection, collection words

"
Class {
	#name : #MgMarkovWordsCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Markov-Generator'
}

{ #category : #adding }
MgMarkovWordsCollection >> addWord: aString [
	self collection addLast: aString
]

{ #category : #accessing }
MgMarkovWordsCollection >> atRandom [
	<return: #String>
	^ self collection atRandom
]

{ #category : #accessing }
MgMarkovWordsCollection >> collection [
	<return: #OrderedCollection>
	^ collection
]

{ #category : #accessing }
MgMarkovWordsCollection >> gtWordsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ (self collection gtItemsFor: aView)
			title: 'Words'
]

{ #category : #testing }
MgMarkovWordsCollection >> hasWords [
	<return: #Boolean>
	^ self numberOfWords isZero not
]

{ #category : #initialization }
MgMarkovWordsCollection >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #convenience }
MgMarkovWordsCollection >> numberOfWords [
	<return: #Integer>
	^ self collection ifNil: 0 ifNotNil: #size
]

{ #category : #printing }
MgMarkovWordsCollection >> printOn: aStream [
	| aMaxIterations |
	self hasWords ifFalse: [ super printOn: aStream. ^ self ].
	aStream
		print: self numberOfWords;
		space;
		nextPutAll: ('item' asPluralBasedOn: self numberOfWords);
		nextPutAll: ': '.
	aMaxIterations := (3 min: self numberOfWords).
	1 to: aMaxIterations do: [ :anIndex |
		aStream nextPutAll: (self collection at: anIndex) asString.
		anIndex = aMaxIterations ifFalse: [ aStream nextPutAll: ', ' ] ].
	self numberOfWords > 3
		ifTrue: [ aStream nextPutAll: '...' ]
]
