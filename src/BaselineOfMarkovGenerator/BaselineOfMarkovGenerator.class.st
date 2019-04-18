Class {
	#name : #BaselineOfMarkovGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfMarkovGenerator
}

{ #category : #baselines }
BaselineOfMarkovGenerator >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec 
			package: 'Markov-Generator'
	]

]
