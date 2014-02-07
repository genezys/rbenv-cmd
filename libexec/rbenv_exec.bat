:: Execute a Ruby command with the current version
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.bat"

:: Retrieve current Ruby version
@ for /f "usebackq" %%i in (`%RBENV_ROOT%\libexec\rbenv_version.bat`) do @ set RUBY_VERSION=%%i
@ if not defined RUBY_VERSION goto RubyVersionNotFound

:: Compute path of current RUBY_VERSION
@ for /f "tokens=1,* delims=| usebackq" %%i in (`findstr /b "%RUBY_VERSION%|" "%RBENV_VERSIONS%"`) do @ set RUBY_PATH=%%j

:: Compute how to call Ruby
@ if "%RUBY_VERSION:~0,5%" == "jruby" (
	if exist "%RUBY_PATH%\bin\%~n1" (
		set COMMAND=jruby -S %*
	) else (
		set COMMAND=jruby %*
	)
) else (
	if exist "%RUBY_PATH%\bin\%~n1" (
		set COMMAND=%*
	) else (
		set COMMAND=ruby %*
	)
)

:: Change current code page to 1252 as it is expected by Ruby
@ for /f "usebackq tokens=2 delims=:" %%i in (`chcp`) do @ set CURRENTCP=%%i
@ chcp 1252 > NUL

:: Alter PATH and call our command
@ set PATH=%RUBY_PATH%\bin;%PATH%
@ call %COMMAND%
@ set RETURN_VALUE=%ERRORLEVEL%

:: Restore old code page
@ chcp %CURRENTCP% > NUL

:: Exit with return value
@ exit /b %RETURN_VALUE%

:RubyVersionNotFound
@ echo(rbenv cannot determine the Ruby version to use. There are no valid global version nor '.ruby-version' file.
@ exit /b 1
