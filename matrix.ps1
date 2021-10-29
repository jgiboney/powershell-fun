# For more information on virtual terminal sequences see,
# https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
$runtime  = 200
$bgColor  = "`e[40m"
$fgColor1 = "`e[97m"
$fgColor2 = "`e[38;2;200;135;205m"
$fgColor3 = "`e[38;2;115;175;170m"
$fgColor4 = "`e[30m"
$symbolSet= (18..26)+(28..31)+(33..127)
$consoleWidth = $Host.UI.RawUI.WindowSize.Width
$consoleHieght = $Host.UI.RawUI.WindowSize.Height
$minimumColumnValue = -$consoleHieght
$columnValues = New-Object int[] $consoleWidth
for ($i = 0; $i -le $consoleWidth-1; $i++) {
  $columnValues[$i] = ($minimumColumnValue..-1) | Get-Random
}

$array1 = New-Object 'object[,]' $consoleWidth,$consoleHieght
for ($i = 0; $i -le $consoleWidth-1; $i++) {
  for ($j = 0; $j -le $consoleHieght-1; $j++) {
    $symbol = $symbolSet | Get-Random -Count 1 | % {[char]$_}
    $array1[$i,$j] = $symbol
  }
}

for ($i = 0; $i -le $runtime; $i++) {
  for ($j = 0; $j -le $consoleWidth-1; $j++) {
    $row = $columnValues[$j]
    if ($row -ge 0) {
      if ($row -lt $consoleHieght) {
        $position = "`e[${row};${j}H"
        $value = $array1[${j},$row]
        Write-Host "${bgColor}${fgColor1}${position}$value"
      }

      if (($row -gt 1) -and ($row -lt $consoleHieght+1)) {
        $lastRow = $row-1
        $position = "`e[${lastRow};${j}H"
        $value = $array1[${j},$lastRow]
        Write-Host "${bgColor}${fgColor2}${position}$value"
      }
      if (($row -gt 3) -and ($row -lt $consoleHieght+3)) {
        $lastRow = $row-3
        $position = "`e[${lastRow};${j}H"
        $value = $array1[${j},$lastRow]
        Write-Host "${bgColor}${fgColor3}${position}$value"
      }
      if (($row -gt 6) -and ($row -lt $consoleHieght+6)) {
        $lastRow = $row-6
        $position = "`e[${lastRow};${j}H"
        $value = $array1[${j},$lastRow]
        Write-Host "${bgColor}${fgColor4}${position}$value"
      }
    }
  }

  for ($j = 0; $j -le $consoleWidth-1; $j++) {
    $columnValues[$j] = $columnValues[$j]+1
    if ($columnValues[$j] -ge $consoleHieght+7) {
      $columnValues[$j] = $minimumColumnValue;
    }
  }
}
# flag{Have You Ever Had A Dream, Neo, That You Were So Sure Was Real?}
