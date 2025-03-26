Dim message, sapi
message=InputBox("What Do You Want Me To Say ?","Speak To Me")
Set sapi=CreateObject("sapi.spvoice")
sapi.Speak message