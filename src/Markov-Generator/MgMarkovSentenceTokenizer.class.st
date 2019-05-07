"
I represent a sentence tokenizer.

I split a text into a sentences. 

Collaborators: 
- MgMarkovDictionaryGenerator: uses me to tokenize a text

Public API and Key Messages

- order
- tokenizeStream:
- tokenizeString:
- sentences

Internal Representation and Key Implementation Points.

Instance Variables

- order: Integer, a minimum number of words in one sentence
- sentences, a generated senteces from a text

"
Class {
	#name : #MgMarkovSentenceTokenizer,
	#superclass : #Object,
	#instVars : [
		'sentences',
		'order'
	],
	#category : #'Markov-Generator'
}

{ #category : #private }
MgMarkovSentenceTokenizer >> addSentence: aString [
	self sentences addLast: aString trimBoth
]

{ #category : #'gt-extension' }
MgMarkovSentenceTokenizer >> gtExampleFor: aView [
	<gtView>
	self sentences ifNil: [ ^ aView empty ].
	self sentences ifNotEmpty: [ ^ aView empty ].
	^ (self class gtDocumentFor: aView)
			title: 'Example';
			priority: 2
]

{ #category : #'gt-extension' }
MgMarkovSentenceTokenizer >> gtSentencesFor: aView [
	<gtView>
	self sentences ifNil: [ ^ aView empty ].
	self sentences ifEmpty: [ ^ aView empty ].
	^ (self sentences gtItemsFor: aView)
			title: 'Sentences';
			priority: 1
]

{ #category : #initialization }
MgMarkovSentenceTokenizer >> initialize [
	super initialize.
	sentences := OrderedCollection new.
	order := 2.
]

{ #category : #testing }
MgMarkovSentenceTokenizer >> isSentenceSplitter: aCharacter [
	^ (aCharacter = $.) or: [ aCharacter = $? ]
]

{ #category : #accessing }
MgMarkovSentenceTokenizer >> order [
	^ order
]

{ #category : #accessing }
MgMarkovSentenceTokenizer >> order: anObject [
	order := anObject
]

{ #category : #accessing }
MgMarkovSentenceTokenizer >> sentences [
	<return: #OrderedCollection of: #String>
	^ sentences
]

{ #category : #private }
MgMarkovSentenceTokenizer >> skipSpaces: aStream [ 
	[ 	| aNextCharacter |
		aNextCharacter := aStream peek.
		aNextCharacter isNotNil and: [ aNextCharacter isSpaceSeparator ]
	] whileTrue: [ aStream next ]
]

{ #category : #actions }
MgMarkovSentenceTokenizer >> tokenizeStream: aStream [
	<return: #OrderedCollection of: #String>
	| aCharacters aNumberOfOrders |
	aCharacters := OrderedCollection new.
	aNumberOfOrders := 1.
	self skipSpaces: aStream.
	[ aStream atEnd ] whileFalse: [ 
		| aCharacter |
		aCharacter := aStream next.
		aCharacters addLast: aCharacter.
		"it should be based on space character"
		aCharacter isSeparator 
			ifTrue: [ 
				aNumberOfOrders := aNumberOfOrders + 1.
				self skipSpaces: aStream ].
		(self isSentenceSplitter: aCharacter) 
			ifTrue: [ 
				aNumberOfOrders >= self order 
					ifTrue: [ 
						self addSentence: ('' join: aCharacters).
						self skipSpaces: aStream.
						aCharacters := OrderedCollection new.
						aNumberOfOrders := 0 ] ] ].
	^ self sentences
]

{ #category : #actions }
MgMarkovSentenceTokenizer >> tokenizeString: aString [
	<return: #OrderedCollection of: #String>
	aString readStreamDo: [ :aStream |
		self tokenizeStream: aStream ].
	^ self sentences
]
