:: Get or set the local Ruby version
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"
@ set RUBY_VERSION=%~1

@ if not defined RUBY_VERSION goto ReadLocalVersion else goto WriteLocalVersion

:WriteLocalVersion

:: Check that version is already managed
@ if not exist "%RBENV_VERSIONS%\%RUBY_VERSION%" goto NotFound

:: Save local version in .ruby-version file
@ echo %RUBY_VERSION%> ".ruby-version"
@ echo(Ruby %RUBY_VERSION% set in local file ".ruby-version"

@ exit /b 0


:ReadLocalVersion

:: Try to read local version from .ruby-version file
@ if exist ".ruby-version" set /p RUBY_VERSION=< ".ruby-version"
@ if not defined RUBY_VERSION goto LocalVersionNotFound

@ echo %RUBY_VERSION%

@ exit /b 0


:LocalVersionNotFound
@ echo(There is no local version defined in an ".ruby-version" file.
@ exit /b 1


:NotFound
@ echo(Ruby %RUBY_VERSION% is not a version managed by rbenv.
@ exit /b 1
