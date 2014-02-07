:: Manually create a new shim by hardlinking the original shim "ruby.bat"
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.bat"
@ set SHIM_NAME=%1

:: Enter shim name interactively if not from command line
@ if not defined SHIM_NAME (
	set /p SHIM_NAME=Enter shim name:
)

:: Create shim by hard linking the default shim
@ mklink /h "%RBENV_SHIMS%\%SHIM_NAME%.bat" "%RBENV_SHIMS%\ruby.bat" > NUL
@ echo Created shim for "%SHIM_NAME%"

@ exit /b 0
