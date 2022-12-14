unit Senha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Data.Win.ADODB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTelaDeSenha = class(TForm)
    Panel1: TPanel;
    btnAcessar: TButton;
    EditSenha: TEdit;
    ImageLogo: TImage;
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    Label1: TLabel;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditSenhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaDeSenha: TTelaDeSenha;

implementation

{$R *.dfm}

uses Home, Agenda;

procedure TTelaDeSenha.btnAcessarClick(Sender: TObject);
begin
  try
    if EditSenha.Text = '123' then
    begin
      Homescrean := THomescrean.Create(self);
      Homescrean.ShowModal;
    end
    else
      ShowMessage('Senha incorreta.');
  finally
    FreeAndNil(HomeScrean);
  end;
end;

procedure TTelaDeSenha.EditSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #13: btnAcessar.Click;
  end;
end;

procedure TTelaDeSenha.FormShow(Sender: TObject);
begin
  EditSenha.SetFocus;
end;

end.
