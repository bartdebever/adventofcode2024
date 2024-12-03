$SafeLevels = 0
$Debug = $false

foreach($line in Get-Content .\input.txt) {
    $split = $line -split ' '
    $decreasing = [int]($split[0]) -gt [int]($split[1])
    $Safe = $true
    for ($i = 0; $i -lt $split.Length - 1; $i++) {
        $current = [int]($split[$i])
        $next = [int]($split[$i + 1])
        if (($decreasing) -and ($current -le $next)) {
            # Series should be decreasing but is increasing
            if ($Debug) {
                Write-Host 'Decreasing but less or equal to next at ' $i $current $next
            }
            $Safe = $false;
            continue;
        }
        elseif (($decreasing -eq $false) -and ($next -le $current)) {
            if ($Debug) {
                Write-Host 'Increasing but less or equal to next at ' + $i $current $next
            }
            $Safe = $false;
            continue
        }
        elseif (($decreasing) -and ($current - $next -gt 3)) {
            if ($Debug) {
                Write-Host 'Decreasing but size is too large at ' + $i $current $next
            }
            $Safe = $false;
            continue
        }
        elseif (($decreasing -eq $false) -and ($next - $current -gt 3)) {
            if ($Debug) {
                Write-Host 'Increasing but size is too large at ' + $i $current $next
            }
            $Safe = $false;
            continue
        }
    }

    if ($Safe -eq $true) {
        if ($Debug) {
            Write-Host 'Safe'
        }

        $SafeLevels++
    }

    if ($Debug) {
        Read-Host
    }

}

Write-Host $SafeLevels