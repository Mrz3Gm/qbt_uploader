@echo off
chcp 65001 > nul
title Configurador de Associacao para .torrent

:: ============================================================================
:: 1. VERIFICAR SE ESTA SENDO EXECUTADO COMO ADMINISTRADOR
:: ============================================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo  [AVISO] Privilegios de Administrador sao necessarios.
    echo  Tentando reiniciar o script como Administrador...
    echo.
    pause
    powershell -Command "Start-Process -FilePath '%~dpnx0' -Verb RunAs"
    exit
)

:: ============================================================================
:: 2. CONFIGURACAO E INTRODUCAO
:: ============================================================================
cls
echo.
echo  ====================================================================
echo    Configurador de Associacao Completa para Arquivos .torrent
echo  ====================================================================
echo.

set "PROG_ID=iBitorrent.TorrentFile"
set "FILE_DESC=Arquivo Torrent (iBit-Uploader)" &:: <<< CORRIGIDO: Removidas as aspas extras daqui
set "ICON_PATH=%~dp0Abittorrent.ico"
set "COMMAND_TO_RUN=%~dp0run_qbt_uploader.bat"

echo  Este script ira criar uma associacao de arquivo personalizada...
echo.(As informacoes exibidas aqui sao as mesmas da versao anterior)
echo.
echo  Pressione qualquer tecla para continuar ou feche esta janela para cancelar.
pause > nul

:: ============================================================================
:: 3. APLICAR AS ALTERACOES NO REGISTRO (COM VERIFICACAO DE ERRO)
:: ============================================================================
echo.
echo  [*] Criando o novo tipo de arquivo e definindo sua descricao...
reg add "HKEY_CLASSES_ROOT\%PROG_ID%" /ve /d "%FILE_DESC%" /f > nul
if %errorlevel% neq 0 ( goto :erro )

echo  [*] Definindo o icone padrao...
reg add "HKEY_CLASSES_ROOT\%PROG_ID%\DefaultIcon" /ve /d "%ICON_PATH%" /f > nul
if %errorlevel% neq 0 ( goto :erro )

echo  [*] Definindo o comando de execucao (shell)...
reg add "HKEY_CLASSES_ROOT\%PROG_ID%\shell" /f > nul
reg add "HKEY_CLASSES_ROOT\%PROG_ID%\shell\open" /ve /d "Enviar para iBittorrent" /f > nul
reg add "HKEY_CLASSES_ROOT\%PROG_ID%\shell\open\command" /ve /d "\"%COMMAND_TO_RUN%\" \"%%1\"" /f > nul
if %errorlevel% neq 0 ( goto :erro )

echo  [*] Associando a extensao .torrent com o novo tipo...
reg add "HKEY_CLASSES_ROOT\.torrent" /ve /d "%PROG_ID%" /f > nul
if %errorlevel% neq 0 ( goto :erro )

echo.
echo  [SUCESSO] O registro foi atualizado com sucesso!
goto :final

:erro
echo.
echo  [ERRO] Ocorreu um problema ao tentar modificar o registro.
echo  Nenhuma alteracao foi completada.
goto :final

:final
:: ============================================================================
:: 4. LIMPEZA E FINALIZACAO
:: ============================================================================
echo.
echo  ====================================================================
echo.
echo  A associacao de arquivo foi criada. Para que o novo icone
echo  apareca corretamente, o cache de icones do Windows precisa ser
echo  atualizado.
echo.
echo  A maneira mais facil e garantida e reiniciar o seu computador.
echo.
echo.
echo  Pressione qualquer tecla para fechar esta janela.
pause > nul
exit