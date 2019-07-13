#Количество строк
$strCount = 10
foreach ($str in 1..$strCount) {
    Write-Host "Строка N $str. НАЧАЛО" -foregroundcolor Green
    $flag = 'OK'
    $tryCount = 0
    do {
       $tryCount += 1
       try {
            ## Здесь эмулируются команды над строками. Используется массив с тремя рандомными значениями от 0 до 2.
            ## Каждое значение применяется в операции деления. Если значение оказывается равным нулю - происходит ошибка.
            $arr = @()
            $arr += get-random -minimum 0 -maximum 3
            $arr += get-random -minimum 0 -maximum 3
            $arr += get-random -minimum 0 -maximum 3
            $(1/$arr[0]) | Out-Null
            $(1/$arr[1]) | Out-Null
            $(1/$arr[2]) | Out-Null
            Write-Host "УСПЕШНАЯ ОБРАБОТКА"
            }

        catch {
            Write-Host "ОШИБКА:" $error[0].ToString() -foregroundcolor red
            
            ## Запрос пользователя о дальнейших действиях в случае ошибки
            $options = [System.Management.Automation.Host.ChoiceDescription[]] @("&Skip", "&Retry", "&Exit")
            [int]$defaultchoice = 2
            $userChoice = $host.UI.PromptForChoice($Title , $Info , $Options,$defaultchoice)

            switch ($userChoice) {
            0 { Write-Host "SKIP. Пропускаем строку"; $flag = 'ERR'; }
            1 { Write-Host "RETRY. Повторяем попытку ($tryCount)"; }
            2 { Write-Host "EXIT. Выходим из скрипта"; exit}
            }
              }
    } while ($flag -eq 'OK' )

Write-Host "Строка N $str. КОНЕЦ`n" -foregroundcolor Green
}

