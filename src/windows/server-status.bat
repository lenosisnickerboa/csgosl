@rem @tasklist /NH /FI "IMAGENAME eq srcds.exe" 2>NUL | find /I /N "srcds.exe">NUL
@wmic process where "name='srcds.exe'" get ExecutablePath /FORMAT:LIST 2>NUL | find /I "ExecutablePath=%cd%\server\srcds.exe">NUL
@if errorlevel 1 (
  @echo not_running
) else (
   @echo running
)