@ setlocal enableextensions enabledelayedexpansion

@ set VERSIONS_PATH=%USERPROFILE%\Tools
@ set DEFAULT_RUBY_VERSION=2.0.0-p353

:: Search for a .ruby-version file to specify the version of ruby to use
@ set DIRECTORY=%CD%
:SearchForRubyVersion
@ if exist "%DIRECTORY%\.ruby-version" (
	set /p RUBY_VERSION= < "%DIRECTORY%\.ruby-version"
	goto :RubyVersionFound
) else (
	pushd "%DIRECTORY%\.."
	set DIRECTORY=!CD!
	popd
	if "%DIRECTORY:~1,-1%" == ":" goto :RubyVersionNotFound
	goto :SearchForRubyVersion
)

:RubyVersionNotFound
@ set RUBY_VERSION=%DEFAULT_RUBY_VERSION%

:RubyVersionFound

:: Compute how to call Ruby based on the version

@ set RUBY_PATH=%VERSIONS_PATH%\ruby-%RUBY_VERSION%
@ if "%RUBY_VERSION:~0,5%" == "jruby" (
	set RUBY_PATH=%VERSIONS_PATH%\%RUBY_VERSION%
	set SCRIPT="!RUBY_PATH!\bin\jruby.exe" -S "%~n0"
	if exist "!RUBY_PATH!\bin\j%~n0.exe" set SCRIPT="!RUBY_PATH!\bin\j%~n0.exe"
) else (
	set SCRIPT="%RUBY_PATH%\bin\ruby.exe" "%RUBY_PATH%\bin\%~n0"
	if exist "%RUBY_PATH%\bin\%~n0.exe" set SCRIPT="%RUBY_PATH%\bin\%~n0.exe"
)

:: Save current code page
@ for /f "usebackq tokens=2 delims=:" %%i in (`chcp`) do @ set CURRENTCP=%%i
:: Change current code page to 1252 as it is expected by Ruby
@ chcp 1252 > NUL
:: Call the good Ruby
@ call %SCRIPT% %*
:: Restore old code page
@ chcp %CURRENTCP% > NUL
