Install-Script -Name Remove-InvalidFileNameChars
Write-Output (Get-Location)

$github_context = $env:GITHUB_CONTEXT | ConvertFrom-Json

function actions_run_url($id) {
    return "https://github.com/$($github_context.repository)/actions/runs/$id"
}

gh issue list -s open | ForEach-Object { 
    $line = $_ -split "\s+"
    Write-Output ('"' + ($line -join '","') + '"')
    $index = $line[0]
    $title = $line[2]
    if ($title -match "^/download$") {
        $issue = gh issue view $index
        Write-Verbose ($issue -join "`n")

        $text_start = $issue.IndexOf("--")
        $text = $issue[($text_start + 1)..$issue.Length]
        Write-Output $text

        foreach ($line in $text -split "`n") {
            $wget_args = [System.Collections.ArrayList]::new()

            if ($line -match "`$name=(.*)") {
                $name = $Matches[1]
            }
            if ($line -match "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]") {
                $url = $Matches[0]
            }
            if ($url) {
                $wget_args.Add($url)
                if ($name) {
                    $wget_args.Add('-O')
                    $wget_args.Add($name)
                }
                
                Start-Process wget -ArgumentList $wget_args -NoNewWindow -Wait
            }
            
        }
        gh issue close $index -c "Task completed, please check $(actions_run_url($github_context.run_id))"
        
    }
}
