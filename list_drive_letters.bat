@echo off
SET NAMES="C:\Maimon\acoustic_recording\scripts\drivenames.txt"

del %NAMES%

for /f "skip=1 delims=" %%x in ('wmic logicaldisk get caption') do (
	echo [%%x] |findstr /r /i [a-z] && echo.%%x >> %NAMES% || echo NONAME>> %TMP%
)

echo -- >> %NAMES%

for /f "skip=1 delims=" %%x in ('wmic logicaldisk get volumename') do (
	echo [%%x] |findstr /r /i [a-z] && echo.%%x >> %NAMES% || echo NONAME>> %NAMES%
)