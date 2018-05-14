#Author zsnmwy
#https://github.com/zsnmwy/max-translation-update-script
#��ȡ�ȶ��� V1
Write-Output "   "  "�벻Ҫ�ڽű�����Ŀ¼ ���  max.zip �Լ� strings.po" " " " " "�ᱻɾ����"
Pause

function judge {
    param(
        [string]$Name = $(throw "Parameter missing: -name Name")
    )
    if ($?) {
        Write-Output "�ɹ� $Name"
        Write-Output "              "
    }
    else {
        Write-Output "ʧ�� $Name"
        Write-Output "    " "�㲻������github��issue" "https://github.com/zsnmwy/max-translation-update-script"
        Pause
        exit
    }
}

$api_url = "http://steamworkshopdownloader.com/api/workshop/935864920"
$file_path = "$pwd"
$wegame_path = "$pwd\OxygenNotIncluded_rail_Data\StreamingAssets\Mods"
$steam_path = "$pwd\OxygenNotIncluded_Data\StreamingAssets\Mods"

$ErrorActionPreference = "SilentlyContinue"
$judge_wegame_path = Test-Path "$wegame_path"
$judge_steam_path = Test-Path "$steam_path"
$judge_file_max = Test-Path "$file_path\max.zip"
$judge_file_po = Test-Path "$file_path\strings.po"
$ErrorActionPreference = "Continue"

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

if ("$judge_file_max" -eq "True") {
    Remove-Item "$file_path\max.zip"
    judge -Name "ɾ��max.zip"
}
if ("$judge_file_po" -eq "True") {
    Remove-Item "$file_path\strings.po"
    judge -Name "ɾ��strings.po"
}

$data = Invoke-WebRequest $api_url
judge -Name "����Workshop API"
$decode = ConvertFrom-Json $data.content

$file_url = $decode.file_url
judge -Name "����file��url"

Write-Output "file-url Ϊ $file_url"

Invoke-WebRequest $file_url -OutFile "$file_path\max.zip"

judge -Name "��������max����"

Write-Output $file_path

Expand-Archive -Path "$file_path\max.zip" -DestinationPath $file_path

judge -Name "��ѹmax.zip����ǰĿ¼"

$test_max = Test-Path "$file_path\strings.po"

if ("$test_max" -eq "False") {
    Write-Output "�Ҳ���strings.po"
    Write-Output "�������滻"
    Pause
    exit
}
$ErrorActionPreference = "SilentlyContinue"
$test_strings_po = Test-Path "$now_path\strings.po"
$ErrorActionPreference = "Continue"
if ("$test_strings_po" -eq "True") {
    $date = Get-Date -Format MMddHHmm
    Write-Output "��⵽ԭ����Ŀ¼���� srtings.po"
    Move-Item -Path "$now_path\strings.po" -Destination "$file_path\strings.po(��ΪԭĿ¼�ķ��룬ȥ�������ڵ������Լ����ߵ����ż����� ʱ��� $date)"
    judge -Name "����ԭstrings.po ���ű�Ŀ¼"
    Move-Item -Path "$file_path\strings.po" -Destination "$now_path\strings.po"
    judge -Name "�ƶ�strings.po ������Ŀ¼��"
}
else {
    Write-Output "û�з���strings.po  ֱ���ƶ�strings.po"
    Move-Item -Path "$file_path\strings.po" -Destination "$now_path\strings.po"
    judge -Name "�ƶ�strings.po ������Ŀ¼��"
}

Write-Output "����max�������" "    "
Write-Output "�������Ϸֱ�Ӿ���max����" "    "
Write-Output "�����⣿��GitHub ����  " "   "  "https://github.com/zsnmwy/max-translation-update-script"
Remove-Item "$file_path\max.zip"
Pause
