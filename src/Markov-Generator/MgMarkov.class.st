"
I generate random sentences based on a given Markov dictionary created by ${class:SoMarkovDictionaryGenerator}$. 

You can initialize the Markov dictionary by ${method:SoMarkov>>#dictionary:}$ and ask for a random sentence by calling ${method:SoMarkov>>#generateText}$.

!! Example

Using the following sentences as input dataset: ${example:SoMarkovExamples>>#threeSentences|codeExpanded=false|previewExpanded=true|previewHeight=180}$

I can generate the following sentence: ${example:SoMarkovExamples>>#generatedSentence|codeExpanded=false|previewExpanded=true|previewHeight=60|previewShow=gtStringFor:}$

To play more with the generated sentences, you can press the play and inspect button in the following example result: ${example:SoMarkovExamples>>#markovWithDictionary|codeExpanded=false|previewExpanded=true}$



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
			actionButtonIcon: #playinspect 
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
