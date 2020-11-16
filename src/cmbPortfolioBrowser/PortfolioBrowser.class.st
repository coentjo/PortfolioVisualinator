Class {
	#name : #PortfolioBrowser,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'browser'
	],
	#category : #cmbPortfolioBrowser
}

{ #category : #'instance creation' }
PortfolioBrowser class >> open [
	"self open"
	| dir |
	dir := '/Users/coen/DownloadSubmissions'. 
	dir := (UIManager default
		chooseDirectory: 'Choose directory'
		path: dir) ifNil: [ '.' ].
	^ self openOn: dir
]

{ #category : #'instance creation' }
PortfolioBrowser class >> openOn: aDirectoryPath [
	"self openOn: '/Users/coen/DownloadSubmissions' "

	^ self new
		baseDirectory: aDirectoryPath;
		open
]

{ #category : #accessing }
PortfolioBrowser >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
PortfolioBrowser >> baseDirectory: aDirectory [
	baseDirectory := aDirectory asFileReference
]

{ #category : #action }
PortfolioBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #solutions.
	browser transmit
		to: #solutions;
		andShow: [ :a | self solutions: a ]
]

{ #category : #action }
PortfolioBrowser >> open [
	self buildBrowser.
	browser openOn: self organizer
]

{ #category : #accessing }
PortfolioBrowser >> organizer [
	^ "RPackageOrganizer" PortfolioOrganizer default
	
]

{ #category : #hierarchy }
PortfolioBrowser >> solutions: constructor [
	constructor list
		display: [ :organizer | (self solutionsOn: organizer) asSet sorted ];
		format: #basename 
]

{ #category : #hierarchy }
PortfolioBrowser >> solutionsOn: organizer [ 
	^ organizer solutionsInDirectory: self baseDirectory 
]
