Class {
	#name : #CanvasBrowser,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #cmbPortfolioBrowser
}

{ #category : #accessing }
CanvasBrowser class >> exampleDirtyCnvs [
	<gtExample>
	self openOn: 
'https://fhict.instructure.com/courses/13666'
]

{ #category : #'instance creation' }
CanvasBrowser class >> openOn: aString [ 
	^ self new 
		url: aString asUrl;
		yourself
]

{ #category : #accessing }
CanvasBrowser >> url: aZnUrl [ 
	url := aZnUrl
]
