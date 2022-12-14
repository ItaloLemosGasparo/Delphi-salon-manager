unit Agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Data.Win.ADODB, Vcl.ComCtrls, Vcl.Mask;

type
  TTelaAgenda = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    LabelPesquisa: TLabel;
    sbtnCancelar: TSpeedButton;
    vimgCancelarSair: TVirtualImageList;
    ImageCollection1: TImageCollection;
    LabelMarcacoes: TLabel;
    SBTNEDIT: TSpeedButton;
    SBTNREMOVE: TSpeedButton;
    SBTNADD: TSpeedButton;
    vimgAEditar: TVirtualImageList;
    vimgARemover: TVirtualImageList;
    vimgAADD: TVirtualImageList;
    DataSelecionada: TDateTimePicker;
    DataSourceAgenda: TDataSource;
    ADOQueryAgenda: TADOQuery;
    RDPor: TRadioGroup;
    MEditNome: TMaskEdit;
    Label2: TLabel;
    procedure sbtnCancelarClick(Sender: TObject);
    procedure sbtnCancelarMouseEnter(Sender: TObject);
    procedure sbtnCancelarMouseLeave(Sender: TObject);
    procedure SBTNADDMouseLeave(Sender: TObject);
    procedure SBTNADDMouseEnter(Sender: TObject);
    procedure SBTNEDITMouseEnter(Sender: TObject);
    procedure SBTNEDITMouseLeave(Sender: TObject);
    procedure SBTNREMOVEMouseEnter(Sender: TObject);
    procedure SBTNREMOVEMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DataSelecionadaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MEditNomeKeyPress(Sender: TObject; var Key: Char);
    procedure RDPorClick(Sender: TObject);
    procedure SBTNADDClick(Sender: TObject);
    procedure SBTNREMOVEClick(Sender: TObject);
    procedure SBTNEDITClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaAgenda: TTelaAgenda;
  firsttime: integer;

implementation

{$R *.dfm}

uses dateutils, AgendaMarcar;

procedure horarios();
var
 data:string;
begin
  WITH TelaAgenda.ADOQueryAgenda DO
  BEGIN

    data := ('CONVERT(DATE, '+QuotedStr(DateToStr(TelaAgenda.DataSelecionada.date))+')');

    CLOSE;
    SQL.Clear;
    if firsttime <> 0 then
      SQL.ADD('drop table #agenda_temp;');

    sql.add('CREATE TABLE #AGENDA_TEMP(HORARIO DATETIME, NOME VARCHAR(64), PROCEDIMENTO VARCHAR(64), TELEFONE VARCHAR(64));');

    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 08:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 08:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 09:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 09:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 10:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 10:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 11:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 11:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 13:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 13:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 14:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 14:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 15:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 15:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 16:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 16:30''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 17:00''), 102), NULL, NULL, NULL);');
    sql.add('INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMAT('+data+', ''yyyy/MM/dd''), '' 17:30''), 102), NULL, NULL, NULL);');

    SQL.ADD('SELECT FORMAT(T.HORARIO, ''hh:mm'') AS HORARIO, O.NOME, O.PROCEDIMENTO, O.TELEFONE FROM AGENDA AS O');
    SQL.ADD('RIGHT JOIN #AGENDA_TEMP AS T ON FORMAT(T.HORARIO, ''dd/MM/yyyy, hh:mm'') = FORMAT(O.HORARIO, ''dd/MM/yyyy, hh:mm'')');
    SQL.ADD('WHERE FORMAT(T.HORARIO, ''dd/MM/yyyy'') = '+ QuotedStr(formatDateTime('DD/MM/YYYY',TelaAgenda.DataSelecionada.date)));
    OPEN;
  END;
end;

procedure TTelaAgenda.DataSelecionadaChange(Sender: TObject);
begin
  horarios();
end;

procedure TTelaAgenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WITH TelaAgenda.ADOQueryAgenda DO
  BEGIN
    CLOSE;
    SQL.Clear;
    SQL.ADD('drop table #agenda_temp;');
    ExecSQL;
  END;
end;

procedure TTelaAgenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:
      TelaAgenda.close;
  end;
end;

procedure TTelaAgenda.FormShow(Sender: TObject);
begin
  DataSelecionada.date := today;
  firsttime:= 0;
  horarios();
  firsttime:= 1;
end;

procedure TTelaAgenda.MEditNomeKeyPress(Sender: TObject; var Key: Char);
begin
if (Key in ['0'..'9']) then
  begin
    Key := #0;
  end;
end;

procedure TTelaAgenda.RDPorClick(Sender: TObject);
begin
  try
    if RDPor.ItemIndex = 0 then
    begin
      LabelPesquisa.Caption := 'Data:';

      DataSelecionada.Enabled := true;
      DataSelecionada.Visible := true;

      MEditNome.Enabled := false;
      MEditNome.Visible := false;
    end
    else if RDPor.ItemIndex = 1 then
    begin
      LabelPesquisa.Caption := 'Nome:';

      MEditNome.Enabled := true;
      MEditNome.Visible := true;

      DataSelecionada.Enabled := false;
      DataSelecionada.Visible := false;
    end;
  except
    ShowMessage('Erro ao mudar a seleção'+#13+'Feche a janela e a abra novamente'+#13+'Caso o problema permaneça, por favor entre em contato com o suporte')
  end;
end;

procedure TTelaAgenda.SBTNADDClick(Sender: TObject);
begin
  try
    TelaMarcaHorario := TTelaMarcaHorario.Create(self);
    TelaMarcaHorario.ShowModal;
  finally
    TelaMarcaHorario.free;
    horarios();
  end;
end;

procedure TTelaAgenda.SBTNADDMouseEnter(Sender: TObject);
begin
//Botão AADD
  SBTNADD.AlignWithMargins:=false;
  SBTNADD.Width :=56;

  vimgAADD.Height := 51;
  vimgAADD.Width := 51;

  SBTNADD.ImageName := 'AADD56';
end;

procedure TTelaAgenda.SBTNADDMouseLeave(Sender: TObject);
begin
//Botão AADD
  SBTNADD.AlignWithMargins:=true;
  SBTNADD.Width :=50;

  vimgAADD.Height := 45;
  vimgAADD.Width := 45;

  SBTNADD.ImageName := 'AADD50';
end;

procedure TTelaAgenda.sbtnCancelarClick(Sender: TObject);
begin
  TelaAgenda.close;
end;

procedure TTelaAgenda.sbtnCancelarMouseEnter(Sender: TObject);
begin
//Botão Sair
  sbtnCancelar.AlignWithMargins:=false;
  sbtnCancelar.Width :=56;

  vimgCancelarSair.Height := 56;
  vimgCancelarSair.Width := 56;

  sbtnCancelar.ImageName := 'Sair56';
end;

procedure TTelaAgenda.sbtnCancelarMouseLeave(Sender: TObject);
begin
//Botão Sair
  sbtnCancelar.AlignWithMargins:=true;
  sbtnCancelar.Width :=50;

  vimgCancelarSair.Height := 50;
  vimgCancelarSair.Width := 50;

  sbtnCancelar.ImageName := 'Sair56';
end;

procedure TTelaAgenda.SBTNEDITClick(Sender: TObject);
begin
  try
    TelaMarcaHorario := TTelaMarcaHorario.Create(self);

    TelaMarcaHorario.emNome.Text := ADOQueryAgenda.FieldByName('NOME').AsString;
    TelaMarcaHorario.emProcedimento.Text := ADOQueryAgenda.FieldByName('PROCEDIMENTO').AsString;
    TelaMarcaHorario.emTelefone.Text := ADOQueryAgenda.FieldByName('TELEFONE').AsString;

    TelaMarcaHorario.ShowModal;
  finally
    TelaMarcaHorario.free;
    horarios();
  end;
end;

procedure TTelaAgenda.SBTNEDITMouseEnter(Sender: TObject);
begin
//Botão AEDIT
  SBTNEDIT.AlignWithMargins:=false;
  SBTNEDIT.Width :=56;

  vimgAEditar.Height := 51;
  vimgAEditar.Width := 51;

  SBTNEDIT.ImageName := 'AEDITAR50';
end;

procedure TTelaAgenda.SBTNEDITMouseLeave(Sender: TObject);
begin
//Botão AEDIT
  SBTNEDIT.AlignWithMargins:=true;
  SBTNEDIT.Width :=50;

  vimgAEditar.Height := 45;
  vimgAEditar.Width := 45;

  SBTNEDIT.ImageName := 'AEDITAR56';
end;

procedure TTelaAgenda.SBTNREMOVEClick(Sender: TObject);
var
  nome, procedimento, telefone:string;
begin
  nome := ADOQueryAgenda.FieldByName('NOME').AsString;
  procedimento := ADOQueryAgenda.FieldByName('PROCEDIMENTO').AsString;
  telefone := ADOQueryAgenda.FieldByName('TELEFONE').AsString;

  if ADOQueryAgenda.FieldByName('NOME').AsString <> '' then
  begin
    case MessageDlg('Tem certeza que deseja desmarcar este horario?', mtConfirmation, [mbOK, mbCancel], 0) of
      mrOk:
        begin
          try
            with ADOQueryAgenda do
            begin
              close;
              sql.Clear;
              sql.Add('FELETE FROM AGENDA');
              sql.Add('WHERE NOME = '+QuotedStr(nome)+' AND PROCEDIMENTO = '+QuotedStr(procedimento)+' AND TELEFONE = '+QuotedStr(telefone));
              ExecSQL;
            end;
          except
            ShowMessage('Erro ao desmarcar este horario'+#13+'Por favor entre em contato com o suporte e detalhe a situação');
          end;
        end;
      mrCancel:
        begin

        end;
    end
  end
  else
  begin
    ShowMessage('Não há cliente marcado neste horario!');
  end;
end;

procedure TTelaAgenda.SBTNREMOVEMouseEnter(Sender: TObject);
begin
//Botão REMOER
  SBTNREMOVE.AlignWithMargins:=false;
  SBTNREMOVE.Width :=56;

  vimgARemover.Height := 51;
  vimgARemover.Width := 51;

  SBTNREMOVE.ImageName := 'ARemove56';
end;

procedure TTelaAgenda.SBTNREMOVEMouseLeave(Sender: TObject);
begin
//Botão REMOER
  SBTNREMOVE.AlignWithMargins:=true;
  SBTNREMOVE.Width :=50;

  vimgARemover.Height := 45;
  vimgARemover.Width := 45;

  SBTNREMOVE.ImageName := 'ARemove50';
end;

end.
