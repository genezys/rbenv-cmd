:: Look for all executables in all Ruby versions installed and create shims
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

:: Search for all executables
@ for /f "usebackq tokens=*" %%i in (`dir /b "%RBENV_VERSIONS%"`) do @(
	for /f "usebackq tokens=*" %%j in (`dir /b "%RBENV_VERSIONS%\%%i\bin\*.bat"`) do @(
		call :CreateShim "%%j"
	)
)

@ exit /b 0


:CreateShim
@ if exist "%RBENV_SHIMS%\%~n1.cmd" del "%RBENV_SHIMS%\%~n1.cmd"
@ mklink /h "%RBENV_SHIMS%\%~n1.cmd" "%RBENV_SHIMS%\ruby.cmd" > NUL
@ exit /b 0
