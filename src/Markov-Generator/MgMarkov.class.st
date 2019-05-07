"
I represent a Markov-chain generator.

I generate a randomized text based on the Markov-chain algorithm.

Collaborators: 
- MgMarkovDictionaryGenerator: I use its result to be able to generate the randomized text

Public API and Key Messages

- dictionary:
- maxWordsInSentence:
- generateText

Internal Representation and Key Implementation Points.

Instance Variables

- dictionary: Dictionary, holds Markov dictionary
- maxWordsInSentence: Integer, number of words in one generated sentence

"
Class {
	#name : #MgMarkov,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'maxWordsInSentence'
	],
	#category : #'Markov-Generator'
}

{ #category : #datasets }
MgMarkov class >> wikipediaSatelliteScienceFiction [
	<gtExample>
	^ self new 
		dictionary: (MgMarkovDictionaryGenerator new 
			readString: MgMarkovDataSets wikipediaSatelliteScienceFiction;
			dictionary)
]

{ #category : #accessing }
MgMarkov >> dictionary [
	^ dictionary
]

{ #category : #accessing }
MgMarkov >> dictionary: anObject [
	dictionary := anObject
]

{ #category : #actions }
MgMarkov >> generateBeginning [
	<return: #MgMarkovLinkedWords>
	^ (self dictionary at: MgMarkovBeginKey uniqueInstance)
			atRandom
]

{ #category : #actions }
MgMarkov >> generateText [
	<return: #String>
	| aKey aSentence aNewWords aNewWord |
	aKey := self generateBeginning.
	aSentence := ' ' join: aKey words.
	1 to: self maxWordsInSentence do: [ :anIndex | 
		aNewWords := self dictionary at: aKey ifAbsent: [ ^ self sentenceWithDot: aSentence ].
		aNewWord := aNewWords atRandom.
		aSentence := aSentence, ' ', aNewWord.
		aKey := aKey fromWord: aNewWord.
	].
	^ self sentenceWithDot: aSentence
]

{ #category : #'gt-extension' }
MgMarkov >> gtDictionaryFor: aView [
	<gtView>
	self dictionary ifNil: [ ^ aView empty ].
	self dictionary ifEmpty: [ ^ aView empty ].
	^ (self dictionary gtItemsFor: aView)
			title: 'Dictionary';
			actionButtonIcon: #playinspect asThemedIcon
				action: [ :aButton | aButton phlow spawnObject: self generateText ]
]

{ #category : #initialization }
MgMarkov >> initialize [
	super initialize.
	dictionary := nil.
	maxWordsInSentence := 10.
]

{ #category : #accessing }
MgMarkov >> maxWordsInSentence [
	^ maxWordsInSentence
]

{ #category : #accessing }
MgMarkov >> maxWordsInSentence: anObject [
	maxWordsInSentence := anObject
]

{ #category : #private }
MgMarkov >> sentenceWithDot: aString [
	(aString last = $,)
		ifTrue: [ aString at: aString size put: $. ].
	^ (aString last = $. or: [ aString last = $? ])
			ifTrue: [ aString ] 
			ifFalse: [ aString, '.' ]
]
