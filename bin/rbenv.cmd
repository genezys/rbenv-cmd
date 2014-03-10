:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ set COMMAND=%~1

@ set PARAMS=
@ set SkipCount=1
@ for %%i in (%*) do @(
	if !SkipCount! leq 0 ( set PARAMS=!PARAMS! %%i ) else ( set /a SkipCount-=1 )
)

@ set RBENV_ROOT=%~dp0..

@ if not defined COMMAND goto Usage

:: Check that COMMAND exists
@ if not exist "%RBENV_ROOT%\libexec\rbenv_%COMMAND%.cmd" goto CommandNotFound

:: Call COMMAND
@ call "%RBENV_ROOT%\libexec\rbenv_%COMMAND%.cmd" %PARAMS%

@ exit /b 0

:Usage
@ echo(rbenv is used to manage multiple versions of Ruby
@ echo(
@ echo(Commands:
@ echo(
@ echo(  add       Add a new version of Ruby to be managed by rbenv
@ echo(  remove    Remove a version of Ruby already managed by rbenv
@ echo(  register  Register an association to open all Ruby files with rbenv
@ echo(  versions  List all versions managed by rbenv
@ echo(  version   Show the current Ruby version used by rbenv
@ echo(  global    Show or change the global Ruby version used by rbenv
@ echo(  exec      Execute a command with the current Ruby version
@ echo(  rehash    Create shims for all scripts available in managed Ruby versions
@ exit /b 1

:CommandNotFound
@ echo("%COMMAND%" is not a valid rbenv command.
@ echo(
@ goto Usage

