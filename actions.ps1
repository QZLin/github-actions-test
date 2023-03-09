Write-Output "Hello, World"

Invoke-WebRequest "http://example.com/index.html" -OutFile "index.html"

Write-Output (Get-Location)
Write-Output (Get-ChildItem)
