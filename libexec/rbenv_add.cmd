:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"
@ set RUBY_PATH=%~f1

@ if not defined RUBY_PATH goto Usage

:: Check that RUBY_PATH is a valid Ruby installation
@ if exist "%RUBY_PATH%\bin\ruby.exe" set RUBY_BIN=%RUBY_PATH%\bin\ruby.exe
@ if exist "%RUBY_PATH%\bin\jruby.exe" set RUBY_BIN=%RUBY_PATH%\bin\jruby.exe
@ if not defined RUBY_BIN goto :InvalidRubyPath

:: Try to detect the Ruby identifier
@ for /f "usebackq tokens=*" %%i in (`call "%RUBY_BIN%" "%RBENV_ROOT%\libexec\ruby_version.rb"`) do @ set RUBY_VERSION=%%i
@ if not defined RUBY_VERSION goto UnknownRuby
@ if "%RUBY_VERSION%" == "" goto UnknownRuby
@ echo Detected Ruby version "%RUBY_VERSION%"

:: Check that version is not already managed
@ if exist "%RBENV_VERSIONS%" (
	findstr /b "%RUBY_VERSION%|" "%RBENV_VERSIONS%" > NUL && goto AlreadyAdded
)

:: Add version to rbenv
@ echo %RUBY_VERSION%^|%RUBY_PATH%>> "%RBENV_VERSIONS%"
@ echo(Added "%RUBY_PATH%" as Ruby "%RUBY_VERSION%"

@ exit /b 0

:Usage
@ echo(Add a new version of Ruby to be managed by rbenv
@ echo(
@ echo(Usage:
@ echo(  %~n0 ^<version_path^>
@ echo(
@ echo(  version_path
@ echo(    path to the home of the Ruby version to be added (not the bin directory)
@ exit /b 1

:UnknownRuby
@ echo('%RUBY_PATH%' contains a version of Ruby that could not be identified.
@ echo(Please check that rbenv\libexec\ruby_version.rb runs successfuly.
@ exit /b 1

:InvalidRubyPath
@ echo('%RUBY_PATH%' does not appear to be a valid Ruby path.
@ echo(It does not contain a bin\ruby executable to be run.
@ exit /b 1

:AlreadyAdded
@ echo('%RUBY_VERSION%' already exists in rbenv list. Remove it first with rbenv remove
@ exit /b 1

