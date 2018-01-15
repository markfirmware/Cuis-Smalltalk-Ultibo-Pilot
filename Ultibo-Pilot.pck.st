'From Cuis 5.0 of 7 November 2016 [latest update: #3245] on 12 January 2018 at 9:03:39 pm'!
'Description Operates Ultibo kernels, especially under QEMU'!
!provides: 'Ultibo-Pilot' 1 1!
!requires: 'Network-Kernel' 1 3 nil!
SystemOrganization addCategory: #'Ultibo-Pilot'!


!classDefinition: #UPPilot category: #'Ultibo-Pilot'!
ActiveModel subclass: #UPPilot
	instanceVariableNames: 'socket statusList loop fetchCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ultibo-Pilot'!
!classDefinition: 'UPPilot class' category: #'Ultibo-Pilot'!
UPPilot class
	instanceVariableNames: ''!

!classDefinition: #UPPilotWindow category: #'Ultibo-Pilot'!
SystemWindow subclass: #UPPilotWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ultibo-Pilot'!
!classDefinition: 'UPPilotWindow class' category: #'Ultibo-Pilot'!
UPPilotWindow class
	instanceVariableNames: ''!


!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:43:39'!
connect
socket ifNotNil:[^self].
socket:=SocketStream openConnectionToHost: NetNameResolver localHostAddress port: 12000.
fetchCounter:=0.
loop:=[[true]whileTrue: [self fetch. Delay forMilliseconds: 100]] newProcess.
loop resume.! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:19:11'!
connected
^socket notNil! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:46:37'!
disconnect
loop terminate.
loop := nil.
socket ifNil:[^self].
socket close.
socket := nil.
self setStatus:'disconnected'! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:18:30'!
disconnected
^socket isNil! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:54:42'!
fetch
|line1 line2 line3|
socket ifNil:[^self].
socket sendCommand:'xp/1db 0x00223000'.
line1:=socket nextLine.
line2:=socket nextLine.
line3:=socket nextLine.
"Transcript show: line1; newLine.
Transcript show:line2; newLine.
Transcript show:line3; newLine."
fetchCounter:=fetchCounter + 1.
self setStatus:'poll counter: ', fetchCounter printString, ' byte at ', line3! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:45:37'!
initialize
statusList:=OrderedCollection with: 'disconnected'! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:45:18'!
setStatus:message
statusList at: 1 put: message.
self changed:#statusList! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:46:15'!
statusIndex
^1! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:05:26'!
statusIndex:index! !

!UPPilot methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:45:52'!
statusList
^statusList! !

!UPPilot class methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:20:31'!
new
^self basicNew initialize! !

!UPPilotWindow methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:53:34'!
buildMorphicWindow
|layout list|
layout:=LayoutMorph newRow.
self addMorph:layout.
list := PluggableListMorph
		model: model
		listGetter: #statusList
		indexGetter: #statusIndex
		indexSetter: #statusIndex:
		mainView: self
		menuGetter: nil
		keystrokeAction: nil.
list layoutSpec: (LayoutSpec proportionalWidth: 1.0).
layout addMorph:  ((PluggableButtonMorph model: model stateGetter: #disconnected action: #connect) label: 'connect').
layout addMorph:  ((PluggableButtonMorph model: model stateGetter: #connected action: #disconnect) label: 'disconnect').
layout addMorph: list! !

!UPPilotWindow methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:57:59'!
delete
self model disconnect.
super delete! !

!UPPilotWindow class methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 20:09:43'!
run
self open: UPPilot new! !

!UPPilotWindow class methodsFor: 'as yet unclassified' stamp: 'mark 1/12/2018 19:49:54'!
worldMenuForOpenGroup
	"Answer the information required to add me to the World menu-->Open.. submenu"

	^ Dictionary new
		
			at: #itemGroup
			put: 10;
		
			at: #itemOrder
			put: 20;
		
			at: #label
			put: 'Ultibo Pilot';
		
			at: #object
			put: self;
		
			at: #selector
			put: #run;
		
			at: #balloonText
			put: 'Develop Ultibo Kernels';
		yourself.! !
