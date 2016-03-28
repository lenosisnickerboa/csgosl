@tasklist /NH /FI "IMAGENAME eq srcds.exe" 2>NUL | find /I /N "srcds.exe">NUL
@if errorlevel 1 (
  @echo not_running
) else (
   @echo running
)