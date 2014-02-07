@ set SCRIPT=%~n0
@ if "%SCRIPT%" == "ruby" set SCRIPT=
@ call "%~dp0..\libexec\rbenv_exec.bat" %SCRIPT% %*
