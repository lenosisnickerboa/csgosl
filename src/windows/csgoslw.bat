:Startcsgosl
@bin\tclkit.exe bin\csgosl.kit %1 %2 %3 %4 %5 %6 %7 %8 %9
@set /A errno=%ERRORLEVEL%
@if %errno% EQU 42 goto Startcsgosl
@if %errno% EQU 84 goto Updatecsgosl
@exit

:Updatecsgosl
@cd updatefolder
@..\bin\unzip -o csgosl.zip
@del /Q csgosl.zip
@set updatefile=update.bat
@echo @timeout 5 > %updatefile%
@echo @xcopy /R /E /H /Y /C "csgosl\*" "..\" >> %updatefile%
@echo @cd .. >> %updatefile%
@echo @start /min bin\csgoslw.bat >> %updatefile%
@echo @exit >> %updatefile%
@start /min %updatefile%
@exit
