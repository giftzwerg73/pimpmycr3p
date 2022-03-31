#!/bin/bash

TOOLSET="/home/ms/cr3p/stm8_toolchain_package/bin"
export PATH="$TOOLSET:$PATH"

$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac task.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac main.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac ppm.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac lcd.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac input.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac buzzer.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac timer.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac eeprom.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac config.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac calc.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_common.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_service.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_global.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_popup.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_mix.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_key.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac menu_timer.c
$TOOLSET/cxstm8 +warn +proto +mods0 +debug -i. -i$TOOLSET/hstm8 -l -pxp -ac vector.c
$TOOLSET/clnk -l$TOOLSET/lib -o cr3p.sm8 -mcr3p.map compile.lkf
$TOOLSET/cvdwarf cr3p.sm8
$TOOLSET/chex -o cr3p.s19 cr3p.sm8

