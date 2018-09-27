@echo off
:: SET NAMES="drivenames.txt" --- Need to set this variable to a full path where you want the drivenames temporary file to be saved --- 

del %NAMES%

for /f "skip=1 delims=" %%x in ('wmic logicaldisk get caption') do (
	echo [%%x] |findstr /r /i [a-z] && echo.%%x >> %NAMES% || echo NONAME>> %TMP%
)

echo -- >> %NAMES%

for /f "skip=1 delims=" %%x in ('wmic logicaldisk get volumename') do (
	echo [%%x] |findstr /r /i [a-z] && echo.%%x >> %NAMES% || echo NONAME>> %NAMES%
)