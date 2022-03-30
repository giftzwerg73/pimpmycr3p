set TOOLSET=C:\COSMIC\FSE_Compilers\CXSTM8

@if "%TOOLSET%"=="" goto NoToolset
@if not "%CHANNELS%"=="" goto ChannelOK
@set CHANNELS=8
:ChannelOK
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% task.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% main.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% ppm.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% lcd.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% input.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% buzzer.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% timer.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% eeprom.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% config.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% calc.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_common.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_service.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_global.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_popup.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_mix.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_key.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% menu_timer.c
%TOOLSET%/cxstm8 +warn +proto +mods0 +debug -i. -i%TOOLSET%/Hstm8 -l  -pxp -ac -dMAX_CHANNELS=%CHANNELS% vector.c
%TOOLSET%/clnk -l%TOOLSET%/Lib -o cr3p.sm8 -mcr3p.map compile.lkf
%TOOLSET%/cvdwarf cr3p.sm8
%TOOLSET%/chex -o cr3p.s19 cr3p.sm8
@goto:EOF

:NoToolset
@echo TOOLSET variable is not set, set it with "set TOOLSET=path"
