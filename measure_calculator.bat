@echo off
setlocal enabledelayedexpansion
echo:

@REM Inputs
if "%1"=="" (
    set /p bpm=Enter the BPM: 
    echo.

    (
        if !bpm! gtr 1000 (
            echo BPM value must be lesser than 1000
        echo.
            pause
            exit
        )
        if !bpm! lss 1 (
            echo BPM value must be greater than 0
        echo.
            pause
            exit
        )
    )
) else (
    set bpm=%1
)

@REM Process Inputs
set comma_position=6
call :pow 10 %comma_position% pow_result
set /a pow_result_by_10=%pow_result% / 10
set /a pow_result_by_100=%pow_result% / 100
set /a measure8=8 * 60 * %pow_result% / %bpm
set /a measure4=4 * 60 * %pow_result% / %bpm
set /a measure2=2 * 60 * %pow_result% / %bpm
set /a measure1=1 * 60 * %pow_result% / %bpm
set /a measure1_2=(60 * %pow_result% / %bpm) / 2
set /a measure1_4=(60 * %pow_result% / %bpm) / 4
set /a measure1_8=(60 * %pow_result% / %bpm) / 8
set /a measure1_16=(60 * %pow_result% / %bpm) / 16
set /a measure1_32=(60 * %pow_result% / %bpm) / 32

@REM Process Outputs
set "measure8_with_commas=!measure8:~0,-%comma_position%!,!measure8:~-%comma_position%!"
set "measure4_with_commas=!measure4:~0,-%comma_position%!,!measure4:~-%comma_position%!"
set "measure2_with_commas=!measure2:~0,-%comma_position%!,!measure2:~-%comma_position%!"

if %measure1% geq %pow_result_by_10% (
set "measure1_with_commas=!measure1:~0,-%comma_position%!,!measure1:~-%comma_position%!"
) else (
set "measure1_with_commas=!measure1:~0,-%comma_position%!,0!measure1:~-%comma_position%!"
)

if %measure1_2% geq %pow_result_by_10% (
    set "measure1_2_with_commas=!measure1_2:~0,-%comma_position%!,!measure1_2:~-%comma_position%!"
) else (
    set "measure1_2_with_commas=!measure1_2:~0,-%comma_position%!,0!measure1_2:~-%comma_position%!"
)

if %measure1_4% geq %pow_result_by_10% (
    set "measure1_4_with_commas=!measure1_4:~0,-%comma_position%!,!measure1_4:~-%comma_position%!"
) else (
    set "measure1_4_with_commas=!measure1_4:~0,-%comma_position%!,0!measure1_4:~-%comma_position%!"
)

if %measure1_8% geq %pow_result_by_10% (
    set "measure1_8_with_commas=!measure1_8:~0,-%comma_position%!,!measure1_8:~-%comma_position%!"
) else if %measure1_8% geq %pow_result_by_100% (
    set "measure1_8_with_commas=!measure1_8:~0,-%comma_position%!,0!measure1_8:~-%comma_position%!"
) else (
    set "measure1_8_with_commas=!measure1_8:~0,-%comma_position%!,00!measure1_8:~-%comma_position%!"
)

if %measure1_16% geq %pow_result_by_10% (
    set "measure1_16_with_commas=!measure1_16:~0,-%comma_position%!,!measure1_16:~-%comma_position%!"
) else if %measure1_16% geq %pow_result_by_100% (
    set "measure1_16_with_commas=!measure1_16:~0,-%comma_position%!,0!measure1_16:~-%comma_position%!"
) else (
    set "measure1_16_with_commas=!measure1_16:~0,-%comma_position%!,00!measure1_16:~-%comma_position%!"
)

if %measure1_32% geq %pow_result_by_10% (
    set "measure1_32_with_commas=!measure1_32:~0,-%comma_position%!,!measure1_32:~-%comma_position%!"
) else if %measure1_32% geq %pow_result_by_100% (
    set "measure1_32_with_commas=!measure1_32:~0,-%comma_position%!,0!measure1_32:~-%comma_position%!"
) else (
    set "measure1_32_with_commas=!measure1_32:~0,-%comma_position%!,00!measure1_32:~-%comma_position%!"
)

@REM Outputs
echo For %bpm% BPM :
echo:
echo 8 measures = !measure8_with_commas! s
echo 4 measures = !measure4_with_commas! s
echo 2 measures = !measure2_with_commas! s
echo:
echo 1 measure = !measure1_with_commas! s
echo:
echo 1/2 measure = !measure1_2_with_commas! s
echo 1/4 measure = !measure1_4_with_commas! s
echo 1/8 measure = !measure1_8_with_commas! s
echo:
echo 1/16 measure = !measure1_16_with_commas! s
echo 1/32 measure = !measure1_32_with_commas! s

@REM Exit
echo:
pause
goto :eof

:pow
set "result=1"
set "base=%1"
set "exponent=%2"
:loop_pow
if %exponent%==0 (
    set "%~3=%result%"
    exit /b
    @REM goto :eof
)
set /a "result*=base"
set /a "exponent-=1"
goto :loop_pow

@REM echo 8 measures = %measure8% s
@REM echo 4 measures = %measure4% s
@REM echo 2 measures = %measure2% s
@REM echo 1 measure = %measure1% s