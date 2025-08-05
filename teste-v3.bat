@echo off
title Menu de Ferramentas TI - v3.0
color 0A

::==================================================
::  Verificação de Administrador
::==================================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if not %errorlevel% equ 0 (
    echo Acesso administrativo necessario.
    echo Reiniciando com privilegios de administrador...
    echo.
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:menu
cls
echo ==================================================
echo     MENU DE POS-FORMATACAO E FERRAMENTAS TI - v3.0
echo ==================================================
echo 1. Restaurar Windows para Padrao de Fabrica
echo 2. Instalar Programas Essenciais (Chrome, AnyDesk, LibreOffice)
echo 3. Rodar Ativador via PowerShell (massgrave.dev)
echo 4. Gerenciar Ferramentas de Limpeza e Reparo
echo 5. Backup de Drivers
echo 6. Gerenciar Testes de Rede
echo 7. Gerenciar Usuarios Locais
echo 8. Informacoes do Sistema
echo 9. Sair
echo ==================================================
set /p opcao=Escolha uma opcao (1-9): 

if "%opcao%"=="1" goto restaurar
if "%opcao%"=="2" goto instalar
if "%opcao%"=="3" goto ativar
if "%opcao%"=="4" goto submenu_limpeza
if "%opcao%"=="5" goto driverbackup
if "%opcao%"=="6" goto submenu_rede
if "%opcao%"=="7" goto usuarios
if "%opcao%"=="8" goto info_sistema
if "%opcao%"=="9" goto fim
echo Opcao invalida!
pause
goto menu

::==================================================
::  Opcoes de Menu
::==================================================
:restaurar
cls
echo Abrindo assistente de restauracao do Windows...
systemreset -factoryreset
pause
goto menu

:instalar
cls
echo --------------------------------------------------
echo |   Instalando Programas Essenciais com winget    |
echo --------------------------------------------------
echo Instalando Google Chrome...
winget install -e --id Google.Chrome
echo Instalando AnyDesk...
winget install -e --id AnyDeskSoftware.AnyDesk
echo Instalando LibreOffice...
winget install -e --id TheDocumentFoundation.LibreOffice
echo Instalacoes concluidas!
pause
goto menu

:ativar
cls
echo Executando ativador via PowerShell (massgrave.dev)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://massgrave.dev/get | iex"
pause
goto menu

:submenu_limpeza
cls
echo ==================================================
echo    SUBMENU DE LIMPEZA E REPARO
echo ==================================================
echo 1. Limpar cache DNS (ipconfig /flushdns)
echo 2. Escanear arquivos do sistema (sfc /scannow)
echo 3. Reparar imagem do Windows (DISM)
echo 4. Voltar ao Menu Principal
echo ==================================================
set /p limpeza_opcao=Escolha uma opcao (1-4): 

if "%limpeza_opcao%"=="1" goto flushdns
if "%limpeza_opcao%"=="2" goto sfc
if "%limpeza_opcao%"=="3" goto dism
if "%limpeza_opcao%"=="4" goto menu
echo Opcao invalida!
pause
goto submenu_limpeza

:flushdns
cls
echo Limpando cache DNS...
ipconfig /flushdns
echo Limpeza concluida!
pause
goto submenu_limpeza

:sfc
cls
echo Executando SFC...
sfc /scannow
echo SFC concluido!
pause
goto submenu_limpeza

:dism
cls
echo Executando DISM...
dism /online /cleanup-image /restorehealth
echo DISM concluido!
pause
goto submenu_limpeza

:driverbackup
cls
set /p destino=Digite o caminho para o backup dos drivers (ex: D:\BackupDrivers): 
if not exist "%destino%" mkdir "%destino%"
echo Criando backup de drivers em %destino%...
dism /online /export-driver /destination:"%destino%"
echo Backup concluido!
pause
goto menu

:submenu_rede
cls
echo ==================================================
echo    SUBMENU DE TESTES DE REDE
echo ==================================================
echo 1. Testar conectividade com Google
echo 2. Exibir configuracoes de rede (ipconfig /all)
echo 3. Voltar ao Menu Principal
echo ==================================================
set /p rede_opcao=Escolha uma opcao (1-3): 

if "%rede_opcao%"=="1" goto ping_google
if "%rede_opcao%"=="2" goto ipconfig_all
if "%rede_opcao%"=="3" goto menu
echo Opcao invalida!
pause
goto submenu_rede

:ping_google
cls
echo Testando conectividade com Google (Pressione Ctrl + C para parar)...
ping google.com -t
pause
goto submenu_rede

:ipconfig_all
cls
echo Exibindo configuracoes de rede...
ipconfig /all
pause
goto submenu_rede

:usuarios
cls
echo Abrindo Gerenciamento de Usuarios Locais...
lusrmgr.msc
pause
goto menu

:info_sistema
cls
echo ==================================================
echo    INFORMACOES DO SISTEMA
echo ==================================================
systeminfo
pause
goto menu

:fim
cls
echo Encerrando o menu.
echo Ate logo!
pause
exit