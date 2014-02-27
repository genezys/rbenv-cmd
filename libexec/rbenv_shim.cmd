:: Manually create a new shim by hardlinking the original shim "ruby.cmd"
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"
@ set SHIM_NAME=%1

:: Enter shim name interactively if not from command line
@ if not defined SHIM_NAME (
	set /p SHIM_NAME=Enter shim name:
)

:: Create shim by hard linking the default shim
@ mklink /h "%RBENV_SHIMS%\%SHIM_NAME%.cmd" "%RBENV_SHIMS%\ruby.cmd" > NUL
@ echo Created shim for "%SHIM_NAME%"

@ exit /b 0
