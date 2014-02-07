:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.bat"

@ for /f "usebackq" %%i in (`%RBENV_ROOT%\libexec\rbenv_version.bat`) do @ set RUBY_VERSION=%%i

:: Check that version is not already managed
@ for /f "tokens=1 delims=|" %%i in (%RBENV_VERSIONS%) do @(
	if "%%i" == "%RUBY_VERSION%" (
		echo( * %%i
	) else (
		echo(   %%i
	)
)

@ exit /b 0
