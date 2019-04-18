"
I tokenize a text into sentences. 
The ${method:MgMarkovSentenceTokenizer>>#isSentenceSplitter:|expanded=true}$ method defines how a sentences ends, e.g., dot character.

You can use ${method:MgMarkovSentenceTokenizer>>#tokenizeStream:}$ or ${method:MgMarkovSentenceTokenizer>>#tokenizeString:}$ to split a text into sentences. The result can be obtained by ${method:MgMarkovSentenceTokenizer>>#sentences}$.

!! Example

The following sentence: ${example:MgMarkovExamples>>#threeSentences|codeExpanded=false|previewExpanded=true|previewShow=gtStringFor:|previewHeight=120}$

Is tokenized into three sentences: ${example:MgMarkovExamples>>#tokenizeThreeSentences|codeExpanded=false|previewExpanded=true|previewShow=gtItemsFor:|previewHeight=120}$
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
