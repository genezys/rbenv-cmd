:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ set COMMAND=%~1

@ set SkipCount=1
@ for %%i in (%*) do @(
	if !SkipCount! leq 0 ( set PARAMS=!PARAMS! %%i ) else ( set /a SkipCount-=1 )
)

@ set RBENV_ROOT=%~dp0..
@ set RBENV_VERSIONS=%RBENV_ROOT%\versions\all.txt

@ if not defined COMMAND goto Usage

:: Check that COMMAND exists
@ if not exist "%RBENV_ROOT%\libexec\rbenv_%COMMAND%.bat" goto CommandNotFound

:: Call COMMAND
@ shift
@ call "%RBENV_ROOT%\libexec\rbenv_%COMMAND%.bat" %PARAMS%

@ exit /b 0

:Usage
@ echo(rbenv is used to manage multiple versions of Ruby
@ echo(
@ echo(Commands:
@ echo(
@ echo(  shim      Create a new shim script to be used by rbenv
@ exit /b 1

:CommandNotFound
@ echo("%COMMAND%" is not a valid rbenv command.
@ echo(
@ goto Usage

