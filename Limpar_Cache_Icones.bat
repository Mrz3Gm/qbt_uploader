@echo off
title Limpador de Cache de Icones do Windows
echo.
echo  Este script ira forcar a reconstrucao do cache de icones do Windows.
echo.
echo  Sua Barra de Tarefas e icones da Area de Trabalho irao desaparecer
echo  por um segundo e depois reaparecer. Isso e normal.
echo.
pause
echo.
echo  [*] Finalizando o processo do Windows Explorer...
taskkill /f /im explorer.exe

echo  [*] Apagando os arquivos de cache de icones...
del /a /q "%localappdata%\IconCache.db"
del /a /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*"

echo  [*] Reiniciando o processo do Windows Explorer...
start explorer.exe

echo.
echo  [SUCESSO] O cache de icones foi limpo. Verifique se os icones foram atualizados.
echo.
pause
exit