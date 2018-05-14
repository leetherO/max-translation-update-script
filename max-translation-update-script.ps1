#Author zsnmwy
#https://github.com/zsnmwy/max-translation-update-script

Write-Output "   "  "�벻Ҫ�ڽű�����Ŀ¼ ���  max.zip �Լ� strings.po" " " " " "�ᱻɾ����"
Pause

function judge {
    param(
        [string]$Name = $(throw "Parameter missing: -name Name")
    )
    if ($?) {
        Write-Output "$Name �ɹ�"
        Write-Output "         "
    }
    else {
        Write-Output "$Name ʧ��"
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

$date = Get-Date -Format MMddHHmm

Move-Item -Path "$now_path\strings_preinstalled_zh_klei.po" -Destination "$file_path\strings_preinstalled_zh_klei.po(��ΪԭĿ¼�ķ��룬ȥ�������ڵ������Լ����ߵ����ż����� $date)"

judge -Name "�ƶ�ԭ����Ŀ¼�ķ����ļ�����ǰ��Ϸ��Ŀ¼ �� ������Ϊ strings_preinstalled_zh_klei.po(��ΪԭĿ¼�ķ��룬ȥ�������ڵ������Լ����ߵ����ż����� $date)"

Move-Item -Path "$file_path\strings.po" -Destination "$now_path\strings_preinstalled_zh_klei.po"

judge -Name "�ƶ�max���뵽����Ŀ¼ ��  ����strings.po������Ϊ strings_preinstalled_zh_klei.po"


Write-Output "����max�������"
Write-Output "�������Ϸѡ����� (wgû��ѡ��ֱ�Ӿ���max����)"
Write-Output "ʵ���ǰѹ��е��ļ����滻����  �൱�� ������ -- �滻"
Remove-Item "$file_path\max.zip"
Pause
