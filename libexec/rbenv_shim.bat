:: Manually create a new shim by hardlinking the original shim "ruby.bat"
@ setlocal

@ set SHIM_NAME=%1
@ if not defined SHIM_NAME (
	set /p SHIM_NAME=Enter shim name:
)

@ mklink /h "%~dp0..\shims\%SHIM_NAME%.bat" "%~dp0..\shims\ruby.bat" > NUL
@ echo Created shim for "%SHIM_NAME%"
