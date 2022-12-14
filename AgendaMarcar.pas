unit AgendaMarcar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Data.DB, Data.Win.ADODB,
  Vcl.Grids, Vcl.DBGrids;

type
  TTelaMarcaHorario = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    emTelefone: TMaskEdit;
    Label4: TLabel;
    emProcedimento: TMaskEdit;
    emNome: TMaskEdit;
    sbtnCancelar: TSpeedButton;
    sbtnConfirmar: TSpeedButton;
    ADOQueryMarcar: TADOQuery;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtnCancelarClick(Sender: TObject);
    procedure sbtnCancelarrClick(Sender: TObject);
    procedure emNomeClick(Sender: TObject);
    procedure sbtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaMarcaHorario: TTelaMarcaHorario;

implementation

{$R *.dfm}

uses Agenda, Character, Clientes;

function contadorDeString(str:string) : integer;
var
  c: char;
begin
  Result := 0;
  for c in str do
    if not Character.IsWhiteSpace(c) then
      inc(Result);
end;

procedure TTelaMarcaHorario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: TelaMarcaHorario.Close;
  end;
end;

procedure TTelaMarcaHorario.emNomeClick(Sender: TObject);
begin
  try
    with TelaClientes do
      codigo := 'Selecionar';
    TelaClientes := TTelaClientes.Create(self);
    TelaClientes.ShowModal;
  finally
    TelaClientes.free;
  end;
end;

procedure TTelaMarcaHorario.sbtnCancelarClick(Sender: TObject);
begin
  TelaMarcaHorario.Close;
end;

procedure TTelaMarcaHorario.sbtnCancelarrClick(Sender: TObject);
begin
  TelaMarcaHorario.Close;
end;

procedure TTelaMarcaHorario.sbtnConfirmarClick(Sender: TObject);
var
  erro:boolean;
begin
  erro:= true;

  if emNome.Text = 'Clique aqui para selecionar o Cliente' then
  begin
    ShowMessage('Não esqueça de selecionar o cliente.');
    erro := false;
  end;

  if contadorDeString(emProcedimento.Text) < 4 then
  begin
    ShowMessage('Não esqueça de informar o procedimento'+#13+'O procedimento não pode ter menos que 4 caracteres.');
    erro := false;
  end;

  if erro then
  try
    try
      case MessageDlg('Confire se os dados estão certos'+#13+
                      'Nome: '+emNome.Text+#13+
                      'Procedimento: '+emProcedimento.Text+#13+
                      'Telefone: '+emTelefone.Text, mtConfirmation, [mbOK, mbCancel], 0) of
        mrOk:
          begin
            with ADOQueryMarcar do
            begin
              close;
              sql.Clear;
              sql.Add('INSERT INTO AGENDA');
              sql.Add('VALUES ('+QuotedStr(Concat(FormatDateTime('dd/MM/yyyy', TelaAgenda.DataSelecionada.DateTime)+' '+TelaAgenda.ADOQueryAgenda.FieldByName('HORARIO').AsString)));
              sql.Add(', '+QuotedStr(emNome.Text)+', '+QuotedStr(emProcedimento.Text)+', '+QuotedStr(emTelefone.Text)+');');
              ExecSQL;
            end;
          end;
      end;
    except
      ShowMessage('Erro ao marca o horario'+#13+'Por favor contate o suporte e detalhe a situação.');
      erro := false;
    end;
  finally
    if erro then
    begin
      ShowMessage('Horario marcado com sucesso!');
      TelaMarcaHorario.close;
    end;
  end;
end;
end.



