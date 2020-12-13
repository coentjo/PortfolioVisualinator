Class {
	#name : #PortfolioBrowser,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'browser',
		'feedback'
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
	"self openOn: '/Users/coen/DownloadsCanvas' "

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
	browser
		column: #solutions;
		column: #projects;
		column: #sourceFiles;
		column: #fileContent.
	browser transmit
		to: #solutions;
		andShow: [ :a | self solutions: a ].
	browser transmit
		from: #solutions;
		to: #projects;
		andShow: [ :a | self projectsIn: a ].
	browser transmit
		from: #projects;
		to: #sourceFiles;
		andShow: [ :a | self sourceFilesIn: a ].
	browser transmit
		from: #sourceFiles;
		to: #fileContent;
		andShow: [ :a | self contentOfFile: a ].
	^ browser
]

{ #category : #hierarchy }
PortfolioBrowser >> contentOfFile: constructor [

	constructor text
		display: [ :fileRef | fileRef contents ];
		act: [ :a :fileRef | 
			self registerMethodIn: fileRef ]
		on: $m entitled: 'method'
]

{ #category : #annotate }
PortfolioBrowser >> feedback [
feedback inspect.
	^ feedback ifNil: [ feedback := Dictionary new ]
]

{ #category : #action }
PortfolioBrowser >> open [
	self buildBrowser.
	browser openOn: self organizer
]

{ #category : #accessing }
PortfolioBrowser >> organizer [
	^ PortfolioOrganizer default	
]

{ #category : #hierarchy }
PortfolioBrowser >> projectsIn: constructor [
	constructor list
		display: [ :organizer | self projectsOn: organizer ];
		format: #ageAndbasename
]

{ #category : #hierarchy }
PortfolioBrowser >> projectsOn: organizer [
	"organizer is a FileReference of a .sln-file"
	| solutionDir |
	solutionDir := organizer parent.
	^ self organizer projectsInDirectory: solutionDir
	
]

{ #category : #annotating }
PortfolioBrowser >> registerMethodIn: aFileReference [

	^ (self feedback
		   at: #methodsFound
		   ifAbsentPut: [ OrderedCollection new ]) add: aFileReference
]

{ #category : #hierarchy }
PortfolioBrowser >> solutions: constructor [
	constructor list
		display: [ :organizer | (self solutionsOn: organizer) asSet sorted ];
		format: #ageAndbasename
]

{ #category : #hierarchy }
PortfolioBrowser >> solutionsOn: organizer [ 
	^ organizer solutionsInDirectory: self baseDirectory 
]

{ #category : #hierarchy }
PortfolioBrowser >> sourceFilesIn: constructor [
	constructor list
		display: [ :organizer | self sourceFilesOn: organizer ];
		format: #ageAndbasename
]

{ #category : #hierarchy }
PortfolioBrowser >> sourceFilesOn: organizer [
	"organizer is FileReference on a csproj"
	^ self organizer sourcesInDirectory: organizer parent
]
