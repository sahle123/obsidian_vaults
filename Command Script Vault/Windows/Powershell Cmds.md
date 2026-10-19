#cmds

### Recursively delete '.DS_store' files.
```
Get-ChildItem * -Include *.DS_store -Recurse | Remove-Item
```

### [How to setup a PowerShell profile](https://lazyadmin.nl/powershell/powershell-profile/)

### Allow PowerShell to run its profile within this instance.
```
powershell.exe -ExecutionPolicy bypass
```

### Opens a new window within the current directory
```
ii .
ii $(pwd) 
ii $((Get-PSReadLineOption).HistorySavePath)
```

### Check environment variables
```
dir env:
ls env:
Get-ChildItem env:
```

### Check path variables
```
echo $env:path
```

### Temporarily add path variables
```
$env:Path += ";C:\Users\salturaigi\AppData\Local\Programs\OpenSSL\";
```