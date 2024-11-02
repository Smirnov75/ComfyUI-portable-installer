@echo off
set COPYRIGHT=-                   ComfyUI (portable) - Max Smirnov 2024.11                  -
rem https://github.com/Smirnov75/ComfyUI-portable-installer
set PYTHONVER=3.10.6
set GITVER=2.39.1
set GITURL=https://github.com/git-for-windows/git/releases/download/v%GITVER%.windows.1/PortableGit-%GITVER%-64-bit.7z.exe
set PYTHONURL=https://www.python.org/ftp/python/%PYTHONVER%/python-%PYTHONVER%-embed-amd64.zip
set COMFYUIURL=https://github.com/comfyanonymous/ComfyUI
set COMFYMANURL=https://github.com/ltdrdata/ComfyUI-Manager
set CONTROLNET=comfyui_controlnet_aux
set CONTROLNETURL=https://github.com/Fannovel16/%CONTROLNET%
set GETPIPURL=https://bootstrap.pypa.io/get-pip.py
set ZIPRURL=https://www.7-zip.org/a/7zr.exe
set ZIPURL=https://www.7-zip.org/a/7z2301-extra.7z
set SD=%~dp0
set PATH=%PATH%;C:\Windows\system32;C:\Windows;%SD%system\git\libexec\git-core
cls
cd /D %SD%
mkdir system\install system\python system\cache\tmp system\git\libexec\git-core system\git\tmp system\git\usr\bin
echo [46m
echo -------------------------------------------------------------------------------
echo %COPYRIGHT%
echo -------------------------------------------------------------------------------
echo [0m
echo ------------------------------------ [92m7-ZIP[0m ------------------------------------
echo.
curl -LO %ZIPRURL%
curl -LO %ZIPURL%
7zr -bso0 -aos x 7z*.7z 7za.exe
echo.
echo ------------------------------------- [92mGIT[0m -------------------------------------
echo.
where /q git
if NOT ERRORLEVEL 1 echo Git: already installed & goto skipgit
curl -LO %GITURL%
7za -bso0 -r -aos x PortableGit*.exe -osystem mingw64 usr
rmdir system\mingw64\share\doc /S /Q
move system\mingw64\share system\git\ >nul
move system\mingw64\ssl system\git\ >nul
move system\mingw64\libexec\git-core\git.exe system\git\libexec\git-core >nul
for %%I in (git-remote-https git-sh-i18n git-sh-setup git-submodule) do move system\mingw64\libexec\git-core\%%I*.* system\git\libexec\git-core >nul
for %%I in (libbrotlicommon libbrotlidec libcrypto libcurl libiconv libidn2 libintl libnghttp2 libpcre2 libpsl libssh2 libssl libunistring libwinpthread libzstd zlib1) do move system\mingw64\libexec\git-core\%%I*.dll system\git\libexec\git-core >nul
for %%I in (msys-2 msys-iconv msys-idn2 msys-intl) do move system\usr\bin\%%I*.* system\git\usr\bin >nul
for %%I in (basename sed sh uname) do move system\usr\bin\%%I.exe system\git\usr\bin >nul
del PortableGit*.exe >nul
rmdir system\mingw64 system\usr /S /Q
:skipgit
echo.
echo ------------------------------------ [92mPYTHON[0m -----------------------------------
echo.
curl -LO %PYTHONURL%
7za -bso0 -r -aos x python*.zip -osystem\python
del system\python\*._pth
echo.
echo ----------------------------------- [92mGET-PIP[0m -----------------------------------
echo.
curl -LO %GETPIPURL%
copy get-pip.py system\python\ >nul
echo.

:comfyui
echo ----------------------------------- [92mCOMFYUI[0m -----------------------------------
echo.
mkdir comfyui
git clone %COMFYUIURL% comfyui
del python*.zip >nul
del get-pip.py >nul
del 7z*.7z >nul
del 7z*.exe >nul

(
echo @echo off
echo set SD=%%~dp0
echo cd /D %%SD%%
echo call environment.bat load
echo cd comfyui
echo python main.py --preview-method latent2rgb
)>comfyui.bat

(
echo @echo off
echo set SD=%%~dp0
echo set PATH=C:\Windows\system32;C:\Windows;%%SD%%system\git\libexec\git-core;%%SD%%system\python;%%SD%%system\python\Scripts;%%PATH%%
echo set PY_LIBS=%%SD%%system\python\Scripts\Lib;%%SD%%system\python\Scripts\Lib\site-packages
echo set PY_PIP=%%SD%%system\python\Scripts
echo set MYPY_CACHE_DIR=%%SD%%system\cache\tmp\
echo set PIP_CACHE_DIR=%%SD%%system\cache\pip\
echo set TEMP=%%SD%%system\cache\
echo set SKIP_VENV=1
echo set PIP_INSTALLER_LOCATION=%%SD%%system\python\get-pip.py
echo set HF_HOME=%%SD%%system\transformers-cache
echo if [%%1]==[] cmd /k
)>environment.bat

(
echo @echo off
echo set SD=%%~dp0
echo cd /D %%SD%%
echo call environment.bat load
echo python system/python/get-pip.py
echo python -m pip install typing_extensions==4.12.2 matrix-client==0.4.0
echo python -m pip install torch==2.5.1 --extra-index-url https://download.pytorch.org/whl/cu124
echo python -m pip install torchvision==0.20.1 xformers==0.0.28.post3 torchaudio==2.5.1 --extra-index-url https://download.pytorch.org/whl/cu124
echo python -m pip install transformers==4.46.1 torchsde==0.2.6 --extra-index-url https://download.pytorch.org/whl/cu124
echo python -m pip install -r comfyui/requirements.txt
echo python -m pip cache purge
echo echo.
echo echo -------------------------------------------------------------------------------
echo echo  Step 2 completed
echo echo -------------------------------------------------------------------------------
echo pause
echo del %%~nx0
)>install_libs.bat

(
echo @echo off
echo set SD=%%~dp0
echo cd /D %%SD%%
echo call environment.bat load
echo echo ------------------------------- [92mCOMFYUI MANAGER[0m -------------------------------
echo git -C comfyui\custom_nodes clone %COMFYMANURL%
echo echo.
echo echo -------------------------------------------------------------------------------
echo echo  Done
echo echo -------------------------------------------------------------------------------
echo pause
echo del %%~nx0
)>install_manager.bat

(
echo @echo off
echo set SD=%%~dp0
echo cd /D %%SD%%
echo call environment.bat load
echo echo ---------------------------------- [92mCONTROLNET[0m ---------------------------------
echo git -C comfyui\custom_nodes clone %CONTROLNETURL%
echo python -m pip install -r comfyui/custom_nodes/%CONTROLNET%/requirements.txt
echo python -m pip cache purge
echo echo.
echo echo -------------------------------------------------------------------------------
echo echo  Done
echo echo -------------------------------------------------------------------------------
echo pause
echo del %%~nx0
)>install_controlnet.bat

(
echo @echo off
echo set SD=%%~dp0
echo cd /D %%SD%%
echo call environment.bat load
echo echo ------------------------------ [92mRMADART CHECKPOINT[0m -----------------------------
echo curl -Lo comfyui\models\checkpoints\rmadart_v110.safetensors https://civitai.com/api/download/models/248717
echo echo.
echo echo ------------------------------- [92mNMKD SUPERSCALE[0m -------------------------------
echo curl --output-dir comfyui\models\upscale_models -LO https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/8x_NMKD-Superscale_150000_G.pth
echo echo.
echo echo -------------------------------------------------------------------------------
echo echo  Done
echo echo -------------------------------------------------------------------------------
echo pause
echo del %%~nx0
)>install_checkpoint.bat

echo.
echo -------------------------------------------------------------------------------
echo  Step 1 completed. Run [96minstall_libs.bat[0m to continue installation.
echo -------------------------------------------------------------------------------

echo [0m
pause
move %~nx0 system\install >nul
