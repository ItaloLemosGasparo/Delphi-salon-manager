unit Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList;

type
  TTelaClientes = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    EditPesquisar: TEdit;
    RDPor: TRadioGroup;
    DBGrid1: TDBGrid;
    ADOQueryClientes: TADOQuery;
    DataSourceClientes: TDataSource;
    ADOQueryTelefones: TADOQuery;
    DataSourceTelefones: TDataSource;
    DBGrid2: TDBGrid;
    LabelTelefones: TLabel;
    LabelMarcacoes: TLabel;
    ImageCollection1: TImageCollection;
    PainelInferior: TPanel;
    sbtnCadastrarCliente: TSpeedButton;
    sbtnEditar: TSpeedButton;
    sbtnRemoveCliente: TSpeedButton;
    sbtnAdicionarTelefone: TSpeedButton;
    sbtnRemoverTelefone: TSpeedButton;
    vimgCRemove: TVirtualImageList;
    vimgTRemove: TVirtualImageList;
    vimgCADD: TVirtualImageList;
    vimgCEDIT: TVirtualImageList;
    vimgTADD: TVirtualImageList;
    vimgPesquisar: TVirtualImageList;
    sbtnPesquisar: TSpeedButton;
    vimgClear: TVirtualImageList;
    sbtnClear: TSpeedButton;
    vimgCancelarSair: TVirtualImageList;
    sbtnCancelar: TSpeedButton;
    Label2: TLabel;
    procedure RDPorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSourceClientesDataChange(Sender: TObject; Field: TField);
    procedure EditPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure imgAdicionarClienteClick(Sender: TObject);
    procedure sbtnCadastrarClienteMouseEnter(Sender: TObject);
    procedure sbtnCadastrarClienteMouseLeave(Sender: TObject);
    procedure sbtnCadastrarClienteClick(Sender: TObject);
    procedure sbtnEditarMouseEnter(Sender: TObject);
    procedure sbtnEditarMouseLeave(Sender: TObject);
    procedure sbtnRemoveClienteMouseEnter(Sender: TObject);
    procedure sbtnRemoveClienteMouseLeave(Sender: TObject);
    procedure sbtnAdicionarTelefoneMouseEnter(Sender: TObject);
    procedure sbtnAdicionarTelefoneMouseLeave(Sender: TObject);
    procedure sbtnRemoverTelefoneMouseEnter(Sender: TObject);
    procedure sbtnRemoverTelefoneMouseLeave(Sender: TObject);
    procedure sbtnPesquisarClick(Sender: TObject);
    procedure sbtnPesquisarMouseEnter(Sender: TObject);
    procedure sbtnPesquisarMouseLeave(Sender: TObject);
    procedure sbtnClearMouseEnter(Sender: TObject);
    procedure sbtnClearMouseLeave(Sender: TObject);
    procedure sbtnCancelarClick(Sender: TObject);
    procedure sbtnCancelarMouseEnter(Sender: TObject);
    procedure sbtnCancelarMouseLeave(Sender: TObject);
    procedure sbtnClearClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtnEditarClick(Sender: TObject);
    procedure sbtnAdicionarTelefoneClick(Sender: TObject);
    procedure sbtnRemoveClienteClick(Sender: TObject);
    procedure sbtnRemoverTelefoneClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaClientes: TTelaClientes;
  codigo: string;

implementation

{$R *.dfm}

uses Senha, ClientesCadastrar, AgendaMarcar;

procedure TTelaClientes.sbtnPesquisarClick(Sender: TObject);
begin
  try
    with ADOQueryClientes do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CLIENTES');

      if EditPesquisar.Text <> '' then
        if RDPor.ItemIndex = 0 then
        begin
          SQL.Add('WHERE NOME LIKE '+QuotedStr('%'+EditPesquisar.Text+'%')+';');
        end
        else if RDPor.ItemIndex = 1 then
        begin
          SQL.Add('WHERE CPF LIKE '+QuotedStr('%'+EditPesquisar.Text+'%')+';');
        end;

      Open;
    end;
  finally
    if ADOQueryClientes.IsEmpty then
      ShowMessage('Nenhum cliente encontrado.');
  end;
end;

procedure TTelaClientes.DataSourceClientesDataChange(Sender: TObject;
  Field: TField);
begin
  if not ADOQueryClientes.IsEmpty then
  begin
    try
      with ADOQueryTelefones do
      begin
        close;
        sql.clear;
        sql.Add('SELECT * FROM TELEFONES WHERE ID = '+ ADOQueryClientes.FieldByName('ID').AsSTRING);
        open;
      end;
    except
      ShowMessage('Erro ao pesquisar telefone');
    end;
  end;
end;

procedure TTelaClientes.EditPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #13: sbtnPesquisar.Click;
  end;
end;

procedure TTelaClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: TelaClientes.close;
  end;
end;

procedure TTelaClientes.FormShow(Sender: TObject);
begin
  EditPesquisar.SetFocus;
  sbtnPesquisar.Click;

  if codigo = 'Cadastar' then
  begin

  end
  else  if codigo = 'Selecionar' then
  begin
    sbtnEditar.Enabled := false;
    sbtnEditar.Visible := false;

    sbtnAdicionarTelefone.Enabled := false;
    sbtnAdicionarTelefone.Visible := false;

    sbtnRemoverTelefone.Enabled := false;
    sbtnRemoverTelefone.Visible := false;

    sbtnRemoveCliente.Enabled := false;
    sbtnRemoveCliente.Visible := false;

    sbtnCadastrarCliente.ImageName := '';
    sbtnCadastrarCliente.Caption := 'Selecionar';
    sbtnCadastrarCliente.Width := 93;
  end;
end;

procedure TTelaClientes.imgAdicionarClienteClick(Sender: TObject);
begin
  try
    TelaCadastrarClientes := TTelaCadastrarClientes.Create(SELF);
    TelaCadastrarClientes.ShowModal;
  finally
    TelaCadastrarClientes.Free;
  end;
end;

procedure TTelaClientes.RDPorClick(Sender: TObject);
begin
  try
    EditPesquisar.Text := '';
    if RDPor.ItemIndex = 0 then
    begin
      EditPesquisar.TextHint := 'Nome...';
      label1.Caption := 'Nome:';
    end
    else if RDPor.ItemIndex = 1 then
    begin
      EditPesquisar.TextHint := 'CPF...';
      label1.Caption := 'CPF:';
    end;
  except
     ShowMessage('Erro em RDPor onClick, por favor chame o suporte!');
  end;
end;

procedure TTelaClientes.sbtnCancelarClick(Sender: TObject);
begin
    TelaClientes.close;
end;

procedure TTelaClientes.sbtnClearClick(Sender: TObject);
begin
  EditPesquisar.text := '';
  RDPor.ItemIndex := 0;
  ADOQueryClientes.Close;
  ADOQueryTelefones.Close;
end;

procedure TTelaClientes.sbtnCadastrarClienteClick(Sender: TObject);
begin
  if codigo = 'Cadastrar' then
  begin
    with TelaCadastrarClientes do
    begin
      codigo := 'Cadastrar';
    end;
    try
      TelaCadastrarClientes := TTelaCadastrarClientes.Create(SELF);
      TelaCadastrarClientes.ShowModal;
    finally
      TelaCadastrarClientes.Free;
      sbtnPesquisar.Click;
    end;
  end
  else if codigo = 'Selecionar' then
  begin
    try
      TelaMarcaHorario.emNome.Text := ADOQueryClientes.FieldByName('NOME').AsString;
      TelaMarcaHorario.emTelefone.Text := ADOQueryTelefones.FieldByName('TELEFONE').AsString;
    except
      ShowMessage('Erro ao Selecionar o cliente.'+#13+'Por favor contato o suporte e detalhe a situação.');
    end;
    TelaClientes.close;
  end;
end;

procedure TTelaClientes.sbtnEditarClick(Sender: TObject);
begin
  if not ADOQueryClientes.IsEmpty then
  begin
    with TelaCadastrarClientes do
    begin
      codigo := 'Editar';
    end;
    try
      TelaCadastrarClientes := TTelaCadastrarClientes.Create(SELF);
      TelaCadastrarClientes.ShowModal;
    finally
      TelaCadastrarClientes.Free;
      sbtnPesquisar.Click;
    end;
  end
  else
  begin
    ShowMessage('Primeiro pesquise e selecione o cliente ao qual deseja editar.');
  end;
end;

procedure TTelaClientes.sbtnAdicionarTelefoneClick(Sender: TObject);
begin
  if not ADOQueryClientes.IsEmpty then
  begin
    with TelaCadastrarClientes do
    begin
      codigo := 'CadastrarTelefone';
    end;
    try
      TelaCadastrarClientes := TTelaCadastrarClientes.Create(SELF);
      TelaCadastrarClientes.ShowModal;
    finally
      TelaCadastrarClientes.Free;
      sbtnPesquisar.Click;
    end;
  end
  else
  begin
    ShowMessage('Primeiro pesquise e selecione o cliente ao qual deseja adicionar um numero de telefone.');
  end;
end;

procedure TTelaClientes.sbtnRemoveClienteClick(Sender: TObject);
var
  erro:boolean;
  id:string;
begin
  id := ADOQueryClientes.FieldByName('ID').AsString;
  erro := true;

  if not ADOQueryClientes.IsEmpty then
  begin
    try
      try
        case MessageDlg('Tem certeza que deseja excluir permanentemente o cliente: '+ADOQueryClientes.FieldByName('NOME').AsString+' ?', mtConfirmation, [mbOK, mbCancel], 0) of
          mrOk: begin
                  if not ADOQueryTelefones.IsEmpty then
                  begin
                    with ADOQueryTelefones do
                    begin
                      close;
                      sql.Clear;
                      sql.Add('DELETE FROM TELEFONES');
                      sql.Add('WHERE ID = ' + id);
                      ExecSQL;
                    end;
                  end;

                  with ADOQueryClientes do
                  begin
                    close;
                    sql.Clear;
                    sql.Add('DELETE FROM CLIENTES');
                    sql.Add('WHERE ID = ' + id);
                    ExecSQL;
                  end;
                end;
          mrCancel:
            erro := false;
        end;
      except
        ShowMessage('Erro ao excluiro cliente. Cliente não excluido!'+#13+'Por favor entre em contato com o suporte e detalhe a situação.');
        erro := false;
      end;
    finally
      if erro then
        ShowMessage('Cliente excluido com sucesso!');
    end;
  end
  else
    ShowMessage('Primeiro pesquise e selecione o cliente ao qual deseja excluir.');
end;

procedure TTelaClientes.sbtnRemoverTelefoneClick(Sender: TObject);
var
  erro:boolean;
  id, telefone:string;
begin
  id := ADOQueryClientes.FieldByName('ID').AsString;
  telefone := ADOQueryTelefones.FieldByName('TELEFONE').AsString;
  erro := true;

  if not ADOQueryClientes.IsEmpty then
  begin
    if not ADOQueryTelefones.IsEmpty then
    begin
      with ADOQueryTelefones do
      begin
        try
          try
            case MessageDlg('Tem certeza que deseja excluir permanentemente o cliente: '+ADOQueryClientes.FieldByName('NOME').AsString+' ?', mtConfirmation, [mbOK, mbCancel], 0) of
              mrOk: begin
                      if not ADOQueryTelefones.IsEmpty then
                      begin
                        with ADOQueryTelefones do
                        begin
                          close;
                          sql.Clear;
                          sql.Add('DELETE FROM TELEFONES');
                          sql.Add('WHERE ID = ' + id + ' AND TELEFONE = ' + QuotedStr(telefone));
                          ExecSQL;
                        end;
                      end;
              end;
            end;
          except
            ShowMessage('Erro ao excluir o telefone. Por favor contate o suporte');
            erro := false;
          end;
        finally
          if erro then
          begin
            ShowMessage('Telefone excluido com sucesso!');
            if not ADOQueryClientes.IsEmpty then
            begin
              try
                with ADOQueryTelefones do
                begin
                  close;
                  sql.clear;
                  sql.Add('SELECT * FROM TELEFONES WHERE ID = '+ ADOQueryClientes.FieldByName('ID').AsSTRING);
                  open;
                end;
              except
                ShowMessage('Erro ao pesquisar telefone');
              end;
            end;
          end;
        end;
      end;
    end
    else
      ShowMessage('Este Cliente não possui nenhum telefone que possa ser excluido.');
  end
  else
    ShowMessage('Primeiro pesquise e selecione o cliente ao qual deseja excluir.');
end;

procedure TTelaClientes.sbtnAdicionarTelefoneMouseEnter(Sender: TObject);
begin
//Botão Cadastrar Telefone
  sbtnAdicionarTelefone.AlignWithMargins:=false;
  sbtnAdicionarTelefone.Width :=56;

  vimgTADD.Height := 56;
  vimgTADD.Width := 56;

  sbtnAdicionarTelefone.ImageName := 'TADD50';
end;

procedure TTelaClientes.sbtnAdicionarTelefoneMouseLeave(Sender: TObject);
begin
//Botão Cadastrar Telefone
  sbtnAdicionarTelefone.AlignWithMargins:=true;
  sbtnAdicionarTelefone.Width :=50;

  vimgTADD.Height := 50;
  vimgTADD.Width := 50;

  sbtnAdicionarTelefone.ImageName := 'TADD50';
end;

procedure TTelaClientes.sbtnCadastrarClienteMouseEnter(Sender: TObject);
begin
//Botão Cadastrar Cliente
  if codigo = 'Cadastrar' then
  begin
    sbtnCadastrarCliente.AlignWithMargins:=false;
    sbtnCadastrarCliente.Width :=56;

    vimgCADD.Height := 56;
    vimgCADD.Width := 56;

    sbtnCadastrarCliente.ImageName := 'CADD56';
  end
  else if codigo = 'Selecionar' then
  begin
    sbtnCadastrarCliente.AlignWithMargins := false;
    sbtnCadastrarCliente.Width := 100;
    sbtnCadastrarCliente.font.Size := 14;  
  end;
end;

procedure TTelaClientes.sbtnCadastrarClienteMouseLeave(Sender: TObject);
begin
//Botão Cadastrar Cliente
  if codigo = 'Cadastrar' then
  begin
    sbtnCadastrarCliente.AlignWithMargins:=true;
    sbtnCadastrarCliente.Width :=50;

    vimgCADD.Height := 50;
    vimgCADD.Width := 50;

    sbtnCadastrarCliente.ImageName := 'CADD50';
  end
  else if codigo = 'Selecionar' then
  begin
    sbtnCadastrarCliente.AlignWithMargins := true;
    sbtnCadastrarCliente.Width := 93;  
    sbtnCadastrarCliente.font.Size := 12; 
  end;
end;

procedure TTelaClientes.sbtnCancelarMouseEnter(Sender: TObject);
begin
//Botão Sair
  sbtnCancelar.AlignWithMargins:=false;
  sbtnCancelar.Width :=56;

  vimgCancelarSair.Height := 56;
  vimgCancelarSair.Width := 56;

  sbtnCancelar.ImageName := 'Sair56';
end;

procedure TTelaClientes.sbtnCancelarMouseLeave(Sender: TObject);
begin
//Botão Sair
  sbtnCancelar.AlignWithMargins:=true;
  sbtnCancelar.Width :=50;

  vimgCancelarSair.Height := 50;
  vimgCancelarSair.Width := 50;

  sbtnCancelar.ImageName := 'Sair56';
end;

procedure TTelaClientes.sbtnClearMouseEnter(Sender: TObject);
begin
//Botão Clear
  sbtnClear.AlignWithMargins:=false;
  sbtnClear.Width :=56;

  vimgClear.Height := 56;
  vimgClear.Width := 56;

  sbtnClear.ImageName := 'Clear56';
end;

procedure TTelaClientes.sbtnClearMouseLeave(Sender: TObject);
begin
//Botão Clear
  sbtnClear.AlignWithMargins:=true;
  sbtnClear.Width :=50;

  vimgClear.Height := 50;
  vimgClear.Width := 50;

  sbtnClear.ImageName := 'Clear50';
end;

procedure TTelaClientes.sbtnEditarMouseEnter(Sender: TObject);
begin
//Botão Editar Cliente
  sbtnEditar.AlignWithMargins:=false;
  sbtnEditar.Width :=56;

  vimgCEDIT.Height := 56;
  vimgCEDIT.Width := 56;

  sbtnEditar.ImageName := 'CEDIT56';
end;

procedure TTelaClientes.sbtnEditarMouseLeave(Sender: TObject);
begin
//Botão Editar Cliente
  sbtnEditar.AlignWithMargins:=true;
  sbtnEditar.Width :=50;

  vimgCEDIT.Height := 50;
  vimgCEDIT.Width := 50;

  sbtnEditar.ImageName := 'CEDIT50';
end;

procedure TTelaClientes.sbtnRemoveClienteMouseEnter(Sender: TObject);
begin
//Botão Editar Cliente
  sbtnRemoveCliente.AlignWithMargins:=false;
  sbtnRemoveCliente.Width :=56;

  vimgCRemove.Height := 56;
  vimgCRemove.Width := 56;

  sbtnRemoveCliente.ImageName := 'CRemove56';
end;

procedure TTelaClientes.sbtnRemoveClienteMouseLeave(Sender: TObject);
begin
//Botão Editar Cliente
  sbtnRemoveCliente.AlignWithMargins:=true;
  sbtnRemoveCliente.Width :=50;

  vimgCRemove.Height := 50;
  vimgCRemove.Width := 50;

  sbtnRemoveCliente.ImageName := 'CRemove50';
end;

procedure TTelaClientes.sbtnRemoverTelefoneMouseEnter(Sender: TObject);
begin
//Botão Cadastrar Telefone
  sbtnRemoverTelefone.AlignWithMargins:=false;
  sbtnRemoverTelefone.Width :=56;

  vimgTRemove.Height := 56;
  vimgTRemove.Width := 56;

  sbtnRemoverTelefone.ImageName := 'TRemove56';
end;

procedure TTelaClientes.sbtnRemoverTelefoneMouseLeave(Sender: TObject);
begin
//Botão Cadastrar Telefone
  sbtnRemoverTelefone.AlignWithMargins:=true;
  sbtnRemoverTelefone.Width :=50;

  vimgTRemove.Height := 50;
  vimgTRemove.Width := 50;

  sbtnRemoverTelefone.ImageName := 'TRemove50';
end;

procedure TTelaClientes.sbtnPesquisarMouseEnter(Sender: TObject);
begin
//Botão Pesquisar
  sbtnPesquisar.AlignWithMargins:=false;
  sbtnPesquisar.Width :=56;

  vimgPesquisar.Height := 56;
  vimgPesquisar.Width := 56;

  sbtnPesquisar.ImageName := 'Pesquisar56';
end;

procedure TTelaClientes.sbtnPesquisarMouseLeave(Sender: TObject);
begin
//Botão Pesquisar
  sbtnPesquisar.AlignWithMargins:=true;
  sbtnPesquisar.Width :=50;

  vimgPesquisar.Height := 50;
  vimgPesquisar.Width := 50;

  sbtnPesquisar.ImageName := 'Pesquisar50';
end;

end.
