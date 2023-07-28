
[string]$PathToFile =  ($ENV:MovieBasePath)+"\Scenes\Scene"+($ENV:SceneNumber)+"\Scene"+($ENV:SceneNumber)+".blend"
Write-Host "File to Render: " + $PathToFile

# Create a python file to run in blender to save a copy of a blend file into a workspace with all references packed into it...
[string]$PythonName =  $ENV:WORKSPACE + "\pythonrun.py"
Write-Host "Python File: " + $PythonName
New-Item $PythonName

# Create Contents of python file and Set Contents of file...
[string]$Python = 'import bpy'
$Python += "`n"
$Python += "`nbpy.ops.file.pack_all()"
$Python += "`nbpy.ops.wm.save_as_mainfile(filepath=`""+$ENV:WORKSPACE+"\BlendToRender.blend`")"
$Python += "`n"
Write-Host $Python
Set-Content $PythonName $Python


# Open File Run Python to pack and save as in workspace
[string]$NewRenderFile = "`""+$ENV:WORKSPACE+"\BlendToRender.blend`""
& "C:\Program Files\Blender Foundation\Blender 3.6\blender.exe" -b $PathToFile -P $PythonName

# Render file and save render to output file name defined here.
[string]$OutputFile = "`""+$ENV:WORKSPACE+"\Scene"+($ENV:SceneNumber)+".avi`""
& "C:\Program Files\Blender Foundation\Blender 3.6\blender.exe" -b $NewRenderFile -o $OutputFile -a
