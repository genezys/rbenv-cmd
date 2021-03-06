:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

:: Use environment variable if it exists
@ if defined RBENV_VERSION (
	set RUBY_VERSION=%RBENV_VERSION%
	set REASON=from environment variable RBENV_VERSION
	goto RubyVersionFound
)

:: Search for a .ruby-version file to specify the version of ruby to use
@ if not defined RBENV_SEARCH_DIR set RBENV_SEARCH_DIR=%CD%
:SearchForRubyVersion
@ if exist "%RBENV_SEARCH_DIR%\.ruby-version" (
	set /p RUBY_VERSION= < "%RBENV_SEARCH_DIR%\.ruby-version"
	set REASON=from %RBENV_SEARCH_DIR%\.ruby-version
	goto RubyVersionFound
) else (
	pushd "%RBENV_SEARCH_DIR%\.."
	set RBENV_SEARCH_DIR=!CD!
	popd
	if "%RBENV_SEARCH_DIR:~1,-1%" == ":" goto RubyVersionNotFound
	goto SearchForRubyVersion
)

:RubyVersionNotFound
:: Retrieve global version
@ if exist "%RBENV_GLOBAL%" (
	set /p RUBY_VERSION= < "%RBENV_GLOBAL%"
	set REASON=from global
)
@ if not defined RUBY_VERSION goto :NoGlobalRuby


:RubyVersionFound
:: Check that version is already managed
@ if not exist "%RBENV_VERSIONS%\%RUBY_VERSION%" goto NotFound

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
@ echo(Ruby %RUBY_VERSION% is not a version managed by rbenv.
@ exit /b 1

:NoGlobalRuby
@ echo(Ruby version could not be found. You should at least define a global version.
@ exit /b 1

