:: Execute a Ruby command with the current version
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

:: Retrieve current Ruby version
@ for /f "usebackq tokens=*" %%i in (`%RBENV_ROOT%\libexec\rbenv_version.cmd --bare`) do @ set RUBY_VERSION=%%i
@ if not defined RUBY_VERSION goto RubyVersionNotFound

:: Compute path of current RUBY_VERSION
@ set RUBY_PATH=%RBENV_VERSIONS%\%RUBY_VERSION%
@ if not exist "%RUBY_PATH%" goto RubyVersionNotManaged

:: Check if we called a script and if it exists in the current Ruby
@ if exist "%RBENV_SHIMS%\%~n1.cmd" (
	if not exist "%RUBY_PATH%\bin\%~n1" goto ScriptNotInThisRubyVersion
)

:: Compute how to call Ruby
@ if "%RUBY_VERSION:~0,5%" == "jruby" (
	if "%~1" == "" (
		set COMMAND=jruby
	) else if "%~1" == "jruby" (
		set COMMAND=%*
	) else if exist "%RUBY_PATH%\bin\%~n1" (
		set COMMAND=jruby -S %*
	) else (
		set COMMAND=jruby %*
	)
) else (
	if "%~1" == "" (
		set COMMAND=ruby %*
	) else if exist "%RUBY_PATH%\bin\%~n1" (
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

:RubyVersionNotManaged
@ echo(Ruby %RUBY_VERSION% is not a version managed by rbenv.
@ exit /b 1

:ScriptNotInThisRubyVersion
@ echo(Ruby %RUBY_VERSION% does not contain a script '%~n1'
@ exit /b 1
