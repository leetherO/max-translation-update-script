function judge {
    param(
        [string]$Name = $(throw "Parameter missing: -name Name")
    )
    if ($?) {
        Write-Output "           " "�ɹ� $Name"
        Write-Output "              "
    }
    else {
        Write-Output "ʧ�� $Name"
        Pause
        exit
    }
}

$wegame_path = "$pwd\OxygenNotIncluded_rail_Data\"
$steam_path = "$pwd\OxygenNotIncluded_Data\"

$ErrorActionPreference = "SilentlyContinue"
$judge_wegame_path = Test-Path "$wegame_path"
$judge_steam_path = Test-Path "$steam_path"
$judge_file_wegame = Test-Path "$wegame_path\debug_enable.txt"
$judge_file_steam = Test-Path "$steam_path\debug_enable.txt"
$ErrorActionPreference = "Continue"

Write-Output "           " "Author zsnmwy" "           "

if ("$judge_file_wegame" -eq "True") {
    Write-Output "          " "��ǰĿ¼Ϊwegame" "          " "�Ѿ����ڿ���debug���ļ� debug_enable.txt �ű������˳�"
    Pause
    exit
}
if ("$judge_file_steam" -eq "True") {
    Write-Output "          " "��ǰĿ¼Ϊsteam" "          " "�Ѿ����ڿ���debug���ļ� debug_enable.txt �ű������˳�"
    Pause
    exit
}

if ( "$judge_wegame_path" -eq "True" ) {
    $now_path = $wegame_path
    Write-Output "wegame $now_path"
    Write-Output "  " "��ǰĿ¼ΪWeGame�汾��ȱ��" "   " "���ʶ�������رյ�ǰ�Ľű�" "   " "���س�����" "   "
    Pause
}
elseif ( "$judge_steam_path" -eq "True" ) {
    $now_path = $steam_path
    Write-Output "steam $now_path"
    Write-Output "  " "��ǰĿ¼ΪSteam�汾��ȱ��" "   " "���ʶ�������رյ�ǰ�Ľű�" "   " "���س�����" "   "
    Pause
}
else {
    Write-Output "    " "��ѽű��ŵ�ȱ������Ϸ��Ŀ¼"
    Write-Output "   "  "Steam�汾��  Ӧ�ðѽű����� \...\OxygenNotIncluded\"  
    Write-Output "   " "WeGame�汾��  Ӧ�ðѽű����� \...\WeGame\rail_apps\ȱ��(2000075)\"
    Pause
    exit
}
New-Item -Path $now_path -Name "debug_enable.txt" -ItemType "file"

Write-Output "           "

judge -Name "����debug_enable.txt"

Write-Output "           " "������Ϸ�󣬰�Ctrl+F4����debug" "           "

Pause