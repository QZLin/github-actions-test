Write-Output (Get-Location)
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

        if ("$text" -match "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]") {
            Write-Verbose $Matches
            $url = $Matches[0]
            wget $url
            gh issue close $index -r "Task Completed"
        }
    }
}
