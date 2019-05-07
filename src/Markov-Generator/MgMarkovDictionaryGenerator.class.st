"
I represent a Markov dictionary generator.

I do generate a dictionary that is used to generate randomized text.

Collaborators: 
- MgMarkovBeginKey: used as a dictinary key 
- MgMarkovLinkedWords: used as a dictinary key or value
- MgMarkovWordsCollection: used as a dictinary value
- MgMarkovSentenceTokenizer: used to split a text to sentences

Public API and Key Messages

- readFile:
- readString:
- readStream: 
- dictionary

Internal Representation and Key Implementation Points.

Instance Variables
- dictionary: Dictionary, a generated Markov dictionary
- order: Integer, number of consecutive words
- sentenceTokenizer, MgMarkovSentenceTokenizer

"
Class {
	#name : #MgMarkovDictionaryGenerator,
	#superclass : #Object,
	#instVars : [
		'order',
		'dictionary',
		'sentenceTokenizer'
	],
	#category : #'Markov-Generator'
}

{ #category : #accessing }
MgMarkovDictionaryGenerator >> beginningKey [
	^ MgMarkovBeginKey uniqueInstance
]

{ #category : #accessing }
MgMarkovDictionaryGenerator >> dictionary [
	^ dictionary
]

{ #category : #actions }
MgMarkovDictionaryGenerator >> fillWithSentence: aSentence [
	| aWords aKeyList |
	aWords := self splitSentence: aSentence.
	"Add a special key with just beginning words"
	self dictionary 
		at: self beginningKey 
		ifPresent: [ :aMarkovCollection | 
			aMarkovCollection addLinkedWords: (
				MgMarkovLinkedWords new words: (aWords first: self order)) ]
		ifAbsentPut: [ MgMarkovLinkedWordsCollection new 
			addLinkedWords: (MgMarkovLinkedWords new words: (aWords first: self order)) ].
	"loop through each word, and if we have enough to add dictionary item, then add"
	aKeyList := OrderedCollection new: self order.
	aWords do: [ :eachWord | 
		aKeyList size < self order 
			ifFalse: [ 
				"If we already have the item, then add it, otherwise add to empty list"
				self dictionary 
					at: (MgMarkovLinkedWords new words: aKeyList asArray)
					ifPresent: [ :aWordsCollection | aWordsCollection addWord: eachWord ]
					ifAbsentPut: [ MgMarkovWordsCollection new addWord: eachWord ].
				"Remove the first word and push last word on to it"
				aKeyList removeFirst. ].
			aKeyList addLast: eachWord ]
]

{ #category : #'gt-extension' }
MgMarkovDictionaryGenerator >> gtDictionaryFor: aView [
	<gtView>
	self dictionary ifNil: [ ^ aView empty ].
	self dictionary ifEmpty: [ ^ aView empty ].
	^ (self dictionary gtItemsFor: aView)
			title: 'Dictionary'
]

{ #category : #initialization }
MgMarkovDictionaryGenerator >> initialize [
	super initialize.
	sentenceTokenizer := MgMarkovSentenceTokenizer new.
	dictionary := Dictionary new.
	order := 2.
]

{ #category : #accessing }
MgMarkovDictionaryGenerator >> order [
	^ order
]

{ #category : #accessing }
MgMarkovDictionaryGenerator >> order: anObject [
	order := anObject
]

{ #category : #actions }
MgMarkovDictionaryGenerator >> readFile: aFileReference [
	aFileReference readStreamEncoded: #utf8 do: [ :aStream |
		self readStream: aStream ]
]

{ #category : #actions }
MgMarkovDictionaryGenerator >> readStream: aStream [
	| aSentences |
	aSentences := self sentenceTokenizer 
		order: self order; 
		tokenizeStream: aStream.
	aSentences do: [ :eachSentence | 
		self fillWithSentence: eachSentence ]
]

{ #category : #actions }
MgMarkovDictionaryGenerator >> readString: aString [
	aString readStreamDo: [ :aStream |
		self readStream: aStream ]
]

{ #category : #accessing }
MgMarkovDictionaryGenerator >> sentenceTokenizer [
	^ sentenceTokenizer
]

{ #category : #accessing }
MgMarkovDictionaryGenerator >> sentenceTokenizer: anObject [
	sentenceTokenizer := anObject
]

{ #category : #actions }
MgMarkovDictionaryGenerator >> splitSentence: aSentence [
	^ String space split: aSentence
]
