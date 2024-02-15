# ComfyUI-portable-installer

Usage of the script:

1. Create a folder anywhere and place the script inside it. ATTENTION: some add-ons for ComfyUI may not work correctly with folder names containing spaces, so it's better to avoid such names.
2. Run the script. After running, portable versions of Python, Git, ComfyUI, and scripts for further installation will be installed. If Git is already installed on the system, portable Git will not be installed into the folder. After installation, the script will be moved to the system/install folder.
3. Continue the installation by running install_libs.bat. After this, ComfyUI is ready for use. To run, use comfyui.bat.
4. Additionally, it is recommended to install a checkpoint: install_checkpoint.bat (an example model chosen is rMadArt v11.0 https://civitai.com/models/18208/rmadart)
5. Additionally, you can install ComfyUI Manager: install_manager.bat
6. If the mentioned add-ons are not needed, you can simply delete the scripts for their installation.

Additional information:

- The script installs everything only in the folder where it is located. The script does not make registry entries or write to other folders, including system temporary folders.
- After installation, you can rename the folder or move it to another location.

------------------------

Применение скрипта:
1. Создать папку в любом месте, и поместить скрипт в неё. ВНИМАНИЕ: некоторые дополнения для ComfyUI некорректно работают с именами папок, содержащих пробелы, поэтому лучше избегать подобных наименований.
2. Запустить скрипт. После запуска установятся портативные версии Python, Git, ComfyUI, а также скрипты для дальнейшей установки. Если Git уже установлен в системе, портативный Git в папку установлен не будет. После установки скрипт будет перенесён в папку system/install.
3. Продолжить установку запустив install_libs.bat. После этого ComfyUI готов к использованию. Для запуска используйте comfyui.bat.
4. Дополнительно рекомендуется установить чекпоинт: install_checkpoint.bat (в качестве примера выбрана модель rMadArt v11.0 https://civitai.com/models/18208/rmadart)
4. Также можно установить ComfyUI Manager: install_manager.bat
6. Если указанные выше дополнения не нужны, то можно просто удалить скрипты для их установки.

Дополнительная информация:
- Скрипт устанавливает всё только в папку в которой находится. Скрипт не производит записи в реестр и в другие папки, включая системные временные папки.
- После установки папку можно переименовывать или переносить в другое место.
