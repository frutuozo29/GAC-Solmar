unit uFuncoesIni;

interface

uses System.IniFiles, System.SysUtils, iwSystem;

type
  TFuncoesIni = class
  public
    class function LerIni(AKey1, AKey2: String; AValorDefault: String = ''): String;
    class procedure GravarIni(AKey1, AKey2, AValor: String);
    class procedure CriaFileIni;
  end;

implementation

class procedure TFuncoesIni.CriaFileIni;
var
  Arquivo: String;
begin
  Arquivo := gsAppPath + gsAppName + '.ini';
  if not FileExists(Arquivo) then
  begin
    TFuncoesIni.GravarIni('SERVIDOR', 'IP', '127.0.0.1');
    TFuncoesIni.GravarIni('SERVIDOR', 'PORTA', '8181');
  end;
end;

class function TFuncoesIni.LerIni(AKey1, AKey2: String;
  AValorDefault: String = ''): String;
var
  Arquivo: String;
  oFileIni: TIniFile;
begin
  Arquivo := gsAppPath + gsAppName + '.ini';
  result := AValorDefault;
  try
    oFileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
      result := oFileIni.ReadString(AKey1, AKey2, AValorDefault);
  finally
    FreeAndNil(oFileIni)
  end;
end;

class procedure TFuncoesIni.GravarIni(AKey1, AKey2, AValor: String);
var
  Arquivo: String;
  oFileIni: TIniFile;
begin
  Arquivo := gsAppPath + gsAppName + '.ini';
  try
    oFileIni := TIniFile.Create(Arquivo);
    oFileIni.WriteString(AKey1, AKey2, AValor);
  finally
    FreeAndNil(oFileIni);
  end;
end;

end.
