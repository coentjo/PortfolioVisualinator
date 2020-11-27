Extension { #name : #AbstractFileReference }

{ #category : #'*cmbPortfolioBrowser' }
AbstractFileReference >> ageAndbasename [
	^ self ageOfFileInWholeDays asString, 'd-' , self basename
]

{ #category : #'*cmbPortfolioBrowser' }
AbstractFileReference >> ageOfFile [
	^ (Timespan
		starting: self fileTimestampForVisualizer
		ending: DateAndTime now) asDuration
]

{ #category : #'*cmbPortfolioBrowser' }
AbstractFileReference >> ageOfFileInWholeDays [
	^ self ageOfFile asDays truncated
]

{ #category : #'*cmbPortfolioBrowser' }
AbstractFileReference >> fileTimestampForVisualizer [
	^ self isDirectory
		ifTrue: [ self dirVisualizerTime ]
		ifFalse: [ self modificationTime ]
]
