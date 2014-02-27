:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

:: Use environment variable if it exists
@ if defined RUBY_VERSION (
	set REASON=from environment variable RUBY_VERSION
	goto RubyVersionFound
)

:: Search for a .ruby-version file to specify the version of ruby to use
@ set DIRECTORY=%CD%
:SearchForRubyVersion
@ if exist "%DIRECTORY%\.ruby-version" (
	set /p RUBY_VERSION= < "%DIRECTORY%\.ruby-version"
	set REASON=from "%DIRECTORY%\.ruby-version"
	goto RubyVersionFound
) else (
	pushd "%DIRECTORY%\.."
	set DIRECTORY=!CD!
	popd
	if "%DIRECTORY:~1,-1%" == ":" goto RubyVersionNotFound
	goto SearchForRubyVersion
)

:RubyVersionNotFound
:: Retrieve global version
@ set /p RUBY_VERSION= < "%RBENV_GLOBAL%"
@ set REASON=from global


:RubyVersionFound
:: Check that version is already managed
@ if not exist "%RBENV_VERSIONS%" goto NotFound
@ findstr /b "%RUBY_VERSION%|" "%RBENV_VERSIONS%" > NUL || goto NotFound

:: Print version and/or reason
@ if "%~1" == "--bare" (
	echo(%RUBY_VERSION%
) else if "%~1" == "--reason" (
	echo(%REASON%
) else (
	echo(%RUBY_VERSION% ^(%REASON%^)
)

@ exit /b 0


:NotFound
@ echo(Ruby "%RUBY_VERSION%" is not a version managed by rbenv.
@ exit /b 1
