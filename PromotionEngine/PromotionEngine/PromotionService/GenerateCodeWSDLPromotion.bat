cd C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin
Set My_Path=%~dp0
wsdl /l:CS /o:"%My_Path%\Promotion.cs" http://localhost:49310/Promotion.asmx