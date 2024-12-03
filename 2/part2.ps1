$SafeLevels = 0
$Debug = $false

function Test-Is-Safe {
    param (
        [string[]]$split,
        [int]$Index,
        [int]$Increment
    )
    
    if (($Index + $Increment -gt $split.Length) -or (($Index + $Increment) -lt 0)) {
        return $false
    }

    $list = [System.Collections.Generic.List[System.string]]$split
    $list.RemoveAt($i + $Increment)
    return Is-Line-Safe $list 1
}

function Is-Line-Safe {
    param (
        [string[]]$split,
        [Parameter(Mandatory=$false)]
        [int]$Iteration = 0
    )
    if ($Debug) {
        Write-Host $split
    }
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
            $Safe = $false
        }
        elseif (($decreasing -eq $false) -and ($next -le $current)) {
            if ($Debug) {
                Write-Host 'Increasing but less or equal to next at ' + $i $current $next
            }
            $Safe = $false
        }
        elseif (($decreasing) -and ($current - $next -gt 3)) {
            if ($Debug) {
                Write-Host 'Decreasing but size is too large at ' + $i $current $next
            }
            $Safe = $false
        }
        elseif (($decreasing -eq $false) -and ($next - $current -gt 3)) {
            if ($Debug) {
                Write-Host 'Increasing but size is too large at ' + $i $current $next
            }
            $Safe = $false
        }

        if ($Safe -eq $false) {
            # Exit early if this was already nested
            if ($Iteration -eq 1) {
                return $false
            }

            return (Test-Is-Safe $split $i -1) -or  (Test-Is-Safe $split $i 1) -or  (Test-Is-Safe $split $i 0)
        }
    }

    if ($Safe -eq $true) {
        if ($Debug) {
            Write-Host 'Safe'
        }
    }

    if ($Debug) {
        Read-Host
    }

    return $Safe


}

foreach($line in Get-Content .\input.txt) {
    $split = $line -split ' '
    if ((Is-Line-Safe $split) -eq $true) {
        $SafeLevels++;
    }
}

Write-Host $SafeLevels