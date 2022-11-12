Write-Output "Hello, World"

Invoke-WebRequest "https://sspool.herokuapp.com/clash/proxies?speed=0.1,900" -OutFile "0_1-900.yaml"

Write-Output (Get-Location)
Write-Output (Get-ChildItem)