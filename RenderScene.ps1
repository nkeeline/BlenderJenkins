
[string]$PathToFile =  ($ENV:MovieBasePath)+"\Scenes\Scene"+($ENV:SceneNumber)+"\Scene"+($ENV:SceneNumber)+".blend"
Write-Host "File to Render: " + $PathToFile

[string]$PythonName =  $ENV:WORKSPACE + "\pythonrun.py"
Write-Host "Python File: " + $PythonName

[string]$Python = 'import bpy'
$Python += "`n"
$Python += "`nbpy.ops.file.pack_all()"
$Python += "`nbpy.ops.wm.save_as_mainfile(filepath=`""+$ENV:WORKSPACE+"\BlendToRender.blend`")"
$Python += "`n"
Write-Host $Python

New-Item $PythonName
Set-Content $PythonName $Python

[string]$NewRenderFile = "`""+$ENV:WORKSPACE+"\BlendToRender.blend`""
[string]$OutputFile = "`""+$ENV:WORKSPACE+"\Scene"+($ENV:SceneNumber)+".avi`""
& "C:\Program Files\Blender Foundation\Blender 3.6\blender.exe" -b $PathToFile -P $PythonName
& "C:\Program Files\Blender Foundation\Blender 3.6\blender.exe" -b $NewRenderFile -o $OutputFile -a
