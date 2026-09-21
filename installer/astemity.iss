; Instalator Astemity dla Windows. Kompilowany przez Inno Setup 6
; na GitHub Actions (runner windows-latest) - patrz .github/workflows/build-exe.yml.
;
; Co robi:
;   1. kopiuje panel do %APPDATA%\Adobe\CEP\extensions\pl.mateusz.prtoolkit
;   2. wpisuje PlayerDebugMode=1 dla CSXS 9-12 (panel jest niepodpisany)
;   3. deinstalator pyta, czy skasowac ustawienia uzytkownika
;
; Wersja i folder z plikami ida z linii polecen:
;   ISCC.exe /DMyVersion=0.3.4 /DPayload=..\panel astemity.iss

#ifndef MyVersion
  #define MyVersion "0.0.0"
#endif
#ifndef Payload
  #define Payload "payload"
#endif

#define MyName "Astemity"
#define ExtId "pl.mateusz.prtoolkit"

[Setup]
AppId={{19474258-4B02-44AE-8F2C-BC6162293360}
AppName={#MyName}
AppVersion={#MyVersion}
AppPublisher=Mateusz Copik
AppSupportURL=https://github.com/mateuszcopik7/astemity-releases
DefaultDirName={userappdata}\Adobe\CEP\extensions\{#ExtId}
DefaultGroupName={#MyName}
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyPage=no
; Bez praw administratora - CEP czyta rozszerzenia z profilu uzytkownika.
PrivilegesRequired=lowest
OutputDir=.
OutputBaseFilename=Astemity-{#MyVersion}-instalator
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
UninstallDisplayName={#MyName} {#MyVersion}
; Panel jest niepodpisany. SmartScreen pokaze ostrzezenie - to normalne,
; opisane w instrukcji dla uzytkownika.

[Languages]
Name: "pl"; MessagesFile: "compiler:Languages\Polish.isl"

[Files]
; Cala paczka panelu. .env (klucz Groq) nie jest w paczce i nie jest ruszany.
Source: "{#Payload}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Registry]
; Bez tego Premiere nie wczyta niepodpisanego rozszerzenia.
Root: HKCU; Subkey: "Software\Adobe\CSXS.9";  ValueType: string; ValueName: "PlayerDebugMode"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletevalue
Root: HKCU; Subkey: "Software\Adobe\CSXS.10"; ValueType: string; ValueName: "PlayerDebugMode"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletevalue
Root: HKCU; Subkey: "Software\Adobe\CSXS.11"; ValueType: string; ValueName: "PlayerDebugMode"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletevalue
Root: HKCU; Subkey: "Software\Adobe\CSXS.12"; ValueType: string; ValueName: "PlayerDebugMode"; ValueData: "1"; Flags: createvalueifdoesntexist uninsdeletevalue

[Messages]
pl.FinishedLabel=Astemity jest zainstalowany.%n%nZamknij Premiere Pro calkowicie i odpal ponownie, potem: Okno > Rozszerzenia > Astemity.

[Code]
// Ustawienia uzytkownika: token do Groq w .env, zestawy efektow,
// presety Grid. Leza poza folderem panelu, zeby przezyc aktualizacje.
function SettingsDir(): String;
begin
  Result := ExpandConstant('{userappdata}') + '\pr-toolkit';
end;

// Deinstalacja: domyslna odpowiedz ZOSTAWIA ustawienia (przycisk Nie).
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Dir: String;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    // Panel po aktualizacjach ma pliki, ktorych instalator nie zna.
    // Folder rozszerzenia kasujemy w calosci.
    DelTree(ExpandConstant('{app}'), True, True, True);

    Dir := SettingsDir();
    if DirExists(Dir) then
    begin
      if MsgBox('Usunac takze Twoje ustawienia Astemity?' + #13#10 + #13#10 +
                'Zestawy efektow, presety Grid i klucz Groq z folderu:' + #13#10 +
                Dir + #13#10 + #13#10 +
                'Nie = ustawienia zostaja na miejscu (zalecane, przydadza sie ' +
                'przy ponownej instalacji).',
                mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES then
        DelTree(Dir, True, True, True);
    end;
  end;
end;
