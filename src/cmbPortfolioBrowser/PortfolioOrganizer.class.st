Class {
	#name : #PortfolioOrganizer,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #cmbPortfolioBrowser
}

{ #category : #singleton }
PortfolioOrganizer class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #'as yet unclassified' }
PortfolioOrganizer >> projectsInDirectory: aFileReference [
	^ aFileReference allChildrenMatching: '*.csproj'
]

{ #category : #'as yet unclassified' }
PortfolioOrganizer >> solutionsInDirectory: aFileReference [

	^ aFileReference allChildrenMatching: '*.sln'
]

{ #category : #hierarchy }
PortfolioOrganizer >> sourcesInDirectory: aFileReference [ 
	^ aFileReference allChildrenMatching: '*.cs'
]
