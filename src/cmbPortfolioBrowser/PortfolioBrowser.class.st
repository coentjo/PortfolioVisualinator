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
		column: #fileContent;
		column: #feedback.
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
	browser transmit
		from: #sourceFiles;
		to: #feedback;
		andShow: [ :a | self showFeedback: a ].
	"from: #sourceFiles;"
	^ browser
]

{ #category : #hierarchy }
PortfolioBrowser >> contentOfFile: constructor [

	constructor text
		display: [ :fileRef | fileRef contents ];
		act: [ :a :fileRef | self registerMethodIn: fileRef ]
		on: $m
		entitled: 'method';
		act: [ :a :fileRef | self registerParamIn: fileRef ]
		on: $p
		entitled: 'parameter';
		act: [ :a :fileRef | self registerReturnValuesIn:  fileRef ]
		on: $m
		entitled: 'returnValue'
]

{ #category : #annotate }
PortfolioBrowser >> feedback [

	^ feedback ifNil: [ feedback := Dictionary new ]
]

{ #category : #printing }
PortfolioBrowser >> feedbackAsString [

	| stream |
	stream := WriteStream on: String new.
	self feedback keys do: [ :key | 
		stream
			nextPutAll: '-------------------';
			nextPutAll: key asString;
			crtab .
			(self feedback at: key) do: [:fileRef | 
				stream nextPutAll: fileRef basename ; cr ]].
	^ stream contents
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
		   at: #methods
		   ifAbsentPut: [ OrderedCollection new ]) add: aFileReference
]

{ #category : #annotating }
PortfolioBrowser >> registerParamIn: aFileReference [

	^ (self feedback at: #parameters ifAbsentPut: [ OrderedCollection new ]) 
		  add: aFileReference
]

{ #category : #annotating }
PortfolioBrowser >> registerReturnValuesIn: aFileReference [

	(self feedback
		   at: #returnValues
		   ifAbsentPut: [ OrderedCollection new ]) add: aFileReference
]

{ #category : #hierarchy }
PortfolioBrowser >> showFeedback: constructor [

	constructor text
		display: [ :x | self feedbackAsString ];
		act: [ :a :fileRef | self feedback inspect ]
		on: $s
		entitled: 'save'
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
