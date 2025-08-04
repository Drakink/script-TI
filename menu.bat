@echo off
title Menu de Pos-Formatação e Ferramentas TI - v2.0
color 0A

:menu
cls
echo ==================================================
echo     MENU DE POS-FORMATACAO E FERRAMENTAS TI - v2.0
echo ==================================================
echo 1. Restaurar Windows para Padrao de Fabrica
echo 2. Instalar Programas Essenciais (Chrome, AnyDesk, LibreOffice)
echo 3. Rodar Ativador via PowerShell (massgrave.dev)
echo 4. Executar Limpeza e Reparo (Flush DNS, SFC, DISM)
echo 5. Backup de Drivers
echo 6. Teste de Rede (Conectividade)
echo 7. Gerenciar Usuarios Locais
echo 8. Sair
echo ==================================================
set /p opcao=Escolha uma opcao (1-8): 

if "%opcao%"=="1" goto restaurar
if "%opcao%"=="2" goto instalar
if "%opcao%"=="3" goto ativar
if "%opcao%"=="4" goto limpeza
if "%opcao%"=="5" goto driverbackup
if "%opcao%"=="6" goto testrede
if "%opcao%"=="7" goto usuarios
if "%opcao%"=="8" goto fim
echo Opcao invalida!
pause
goto menu

:restaurar
cls
echo Abrindo assistente de restauracao do Windows...
systemreset -factoryreset
pause
goto menu

:instalar
cls
echo Instalando Google Chrome...
winget install -e --id Google.Chrome
echo Instalando AnyDesk...
winget install -e --id AnyDeskSoftware.AnyDesk
echo Instalando LibreOffice...
winget install -e --id TheDocumentFoundation.LibreOffice
echo Instalacoes concluídas!
pause
goto menu

:ativar
cls
echo Executando ativador via PowerShell...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://massgrave.dev/get | iex"
pause
goto menu

:limpeza
cls
echo Limpando cache DNS...
ipconfig /flushdns
echo Executando SFC...
sfc /scannow
echo Executando DISM...
dism /online /cleanup-image /restorehealth
echo Tarefas de limpeza e reparo concluídas!
pause
goto menu

:driverbackup
cls
echo Criando backup de drivers em C:\DriverBackup...
mkdir C:\DriverBackup
dism /online /export-driver /destination:C:\DriverBackup
echo Backup concluído!
pause
goto menu

:testrede
cls
echo Testando conectividade com Google (Pressione Ctrl + C para parar)...
ping google.com -t
pause
goto menu

:usuarios
cls
echo Abrindo Gerenciamento de Usuarios Locais...
lusrmgr.msc
pause
goto menu

:fim
cls
echo Encerrando o menu. Ate logo!
pause
exit
