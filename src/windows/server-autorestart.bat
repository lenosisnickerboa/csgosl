@REM echo wrapper called with %*
:StartServer
%*
@echo Server was stopped or crashed, restarting...
goto StartServer
