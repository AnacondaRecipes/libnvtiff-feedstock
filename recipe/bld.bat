
if not exist %PREFIX% mkdir %PREFIX%

move lib\*.lib %LIBRARY_LIB%
if errorlevel 1 exit 1

move bin\*.dll %LIBRARY_BIN%
if errorlevel 1 exit 1

move include\* %LIBRARY_INC%
if errorlevel 1 exit 1
