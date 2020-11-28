Class {
	#name : #CanvasBrowser,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #cmbPortfolioBrowser
}

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
