:: Get or set the global Ruby version
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.bat"
@ set RUBY_VERSION=%~1

@ if not defined RUBY_VERSION goto ReadGlobalVersion else goto WriteGlobalVersion

:WriteGlobalVersion

:: Check that version is already managed
@ if not exist "%RBENV_VERSIONS%" goto NotFound
@ findstr /b "%RUBY_VERSION%|" "%RBENV_VERSIONS%" > NUL || goto NotFound

:: Save global version in rbenv configuration
@ echo %RUBY_VERSION%> "%RBENV_GLOBAL%"
@ echo(Ruby "%RUBY_VERSION%" set as global

@ exit /b 0


:ReadGlobalVersion

:: Try to read global version from rbenv configuration
@ if exist "%RBENV_GLOBAL%" set /p RUBY_VERSION=< "%RBENV_GLOBAL%"
@ if not defined RUBY_VERSION goto GlobalVersionNotFound

@ echo %RUBY_VERSION%

@ exit /b 0


:GlobalVersionNotFound
@ echo(There is no global version defined
@ exit /b 1


:NotFound
@ echo(Ruby "%RUBY_VERSION%" is not a version managed by rbenv.
@ exit /b 1
