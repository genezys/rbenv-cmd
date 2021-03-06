:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

:: Ask for reason first or RUBY_VERSION will already be defined
@ for /f "usebackq tokens=*" %%i in (`call "%RBENV_ROOT%\libexec\rbenv_version.cmd" --reason`) do @ set REASON=%%i
@ for /f "usebackq tokens=*" %%i in (`call "%RBENV_ROOT%\libexec\rbenv_version.cmd" --bare`) do @ set RUBY_VERSION=%%i

:: Check that version is not already managed
@ for /f "usebackq tokens=*" %%i in (`dir /b "%RBENV_VERSIONS%"`) do @(
	if "%%i" == "%RUBY_VERSION%" (
		echo( * %%i ^(%REASON%^)
	) else (
		echo(   %%i
	)
)

@ exit /b 0
