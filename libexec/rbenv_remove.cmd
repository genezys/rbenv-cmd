:: Remove a Ruby version from rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"
@ set RUBY_VERSION=%~1

@ if not defined RUBY_VERSION goto Usage

:: Check that version is already managed
@ if not exist "%RBENV_VERSIONS%\%RUBY_VERSION%" goto NotFound

:: Check that version is not global
@ if exist "%RBENV_GLOBAL%" (
	set /p RUBY_GLOBAL_VERSION= <"%RBENV_GLOBAL%"
	if "%RUBY_VERSION%" == "!RUBY_GLOBAL_VERSION!" goto CannotRemoveGlobal
)

:: Remove version from rbenv
@ rmdir "%RBENV_VERSIONS%\%RUBY_VERSION%"
@ echo(Removed "%RUBY_VERSION%"

@ exit /b 0

:Usage
@ echo(Remove a version of Ruby from rbenv
@ echo(
@ echo(Usage:
@ echo(  %~n0 ^<version_identifier^>
@ echo(
@ echo(  version_identifier
@ echo(    unique identifier of the version to be removed (like 2.0.0-p253, or jruby-1.7.10)
@ exit /b 1

:NotFound
@ echo(Ruby "%RUBY_VERSION%" is not a version managed by rbenv.
@ exit /b 1

:CannotRemoveGlobal
@ echo(Ruby "%RUBY_VERSION%" cannot be removed as it is defined in rbenv as the global version.
@ exit /b 1

