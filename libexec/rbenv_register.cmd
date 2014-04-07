:: Add a new Ruby version to rbenv
@ setlocal EnableDelayedExpansion

@ call "%~dp0common_vars.cmd"

@reg add "HKCR\.rb" /ve /t REG_SZ /d "RubyFile" /f > NUL
@reg add "HKCR\RubyFile" /ve /t REG_SZ /d "Ruby File" /f > NUL
@reg add "HKCR\RubyFile\DefaultIcon" /ve /t REG_SZ /d "%RBENV_ROOT%\resources\ruby.ico" /f > NUL
@reg add "HKCR\RubyFile\shell\open\command" /ve /t REG_SZ /d "\"%RBENV_ROOT%\libexec\rbenv_exec.cmd\" \"%%1\" %%*" /f > NUL

@ echo(Ruby files are now associated with rbenv-cmd.

@ exit /b 0
