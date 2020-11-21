"
PortfolioVisoginator helps getting insight intpo a student software portfolio (for now in C#). 

It is build loosely after the PBE2CodeEditor tutorial described in the book 'Deep into Pharo' in the chapter about The Glamorous Toolkit.  

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #PortfolioVisoginator,
	#superclass : #Object,
	#instVars : [
		'baseDirectory',
		'browser'
	],
	#category : #cmbPortfolioBrowser
}

{ #category : #'instance creation' }
PortfolioVisoginator class >> openOn: aString [
	^ self new
		baseDirectory: aString asFileReference;
		open
]

{ #category : #accessing }
PortfolioVisoginator >> baseDirectory [
	^ baseDirectory
]

{ #category : #accessing }
PortfolioVisoginator >> baseDirectory: aFileReference [
	baseDirectory := aFileReference
]

{ #category : #accessing }
PortfolioVisoginator >> buildBrowser [
	browser := GLMTabulator new.
	browser 
		row: #navigator;
		row: #source.
	browser transmit 
		to: #navigator;
		andShow: [ :a | self navigatorIn: a ]
]

{ #category : #'accessingas yet unclassified' }
PortfolioVisoginator >> navigatorIn: constructor [
	| portfolioBrowser |
	portfolioBrowser := PortfolioBrowser new.
	portfolioBrowser
		baseDirectory: self baseDirectory.
	constructor custom: portfolioBrowser
]

{ #category : #action }
PortfolioVisoginator >> open [
	self buildBrowser.
	browser openOn: self organizer
]

{ #category : #hierarchy }
PortfolioVisoginator >> organizer [
	^ PortfolioOrganizer default 
]
