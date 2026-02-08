rem @echo off

mkdir %~dp0\Assets


mkdir %~dp0\Assets\Plus
copy %~dp0\Languages.iss %~dp0\Assets\Plus\
copy %~dp0\license.txt %~dp0\Assets\Plus\
copy %~dp0\Sandboxie.ini %~dp0\Assets\Plus\
copy %~dp0\Sandboxie-Plus.ini %~dp0\Assets\Plus\
copy %~dp0\Sandboxie-Plus.iss %~dp0\Assets\Plus\
copy %~dp0\SandManInstall.ico %~dp0\Assets\Plus\
copy %~dp0\SbieWallpaper.png %~dp0\Assets\Plus\
mkdir %~dp0\Assets\Plus\isl
copy %~dp0\isl\* %~dp0\Assets\Plus\isl\

