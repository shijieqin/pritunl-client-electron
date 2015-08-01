#define MyAppName "Pritunl"
#define MyAppVersion "0.10.6"
#define MyAppPublisher "Pritunl"
#define MyAppURL "https://pritunl.com/"
#define MyAppExeName "pritunl.exe"

[Setup]
AppId={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
PrivilegesRequired=admin
DisableProgramGroupPage=yes
OutputDir=..\build\
OutputBaseFilename={#MyAppName}
SetupIconFile=..\client\www\img\logo.ico
UninstallDisplayName=Pritunl Client
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
Source: "..\build\win\pritunl-win32\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: PreInstall
Source: "..\tuntap_win\*"; DestDir: "{app}\tuntap"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\openvpn_win\*"; DestDir: "{app}\openvpn"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\resources_win\post_install\post_install.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\resources_win\pre_uninstall\pre_uninstall.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\service_win\nssm.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\service\service.exe"; DestDir: "{app}"; DestName: "pritunl-service.exe"; Flags: ignoreversion recursesubdirs createallsubdirs

[Code]
var ResultCode: Integer;
procedure PreInstall();
begin
    Exec('net.exe', 'stop pritunl', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec('taskkill.exe', '/F /IM pritunl.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[InstallDelete]
Type: filesandordirs; Name: "{app}"

[Run]
Filename: "{app}\post_install.exe"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."

[UninstallRun]
Filename: "{app}\pre_uninstall.exe"; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: filesandordirs; Name: "C:\ProgramData\{#MyAppName}"
