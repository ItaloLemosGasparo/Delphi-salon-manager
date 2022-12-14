unit ClientesCadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask;

type
  TTelaCadastrarClientes = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    btnCadastrar: TButton;
    btnCancelar: TButton;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    EditEndereco: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ADOQueryCadastrarClientes: TADOQuery;
    ADOQueryCadastrarTelefone: TADOQuery;
    EditTelefone: TMaskEdit;
    EditCpf: TMaskEdit;
    EditNome: TMaskEdit;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditCpfChange(Sender: TObject);
    procedure EditTelefoneChange(Sender: TObject);
    procedure EditNomeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadastrarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaCadastrarClientes: TTelaCadastrarClientes;
  //Flags
  telefoneE, cpfE : integer;
  codigo: string;

implementation

{$R *.dfm}

uses Senha, Character, Clientes;

function contadorDeString(str:string) : integer;
var
  c: char;
begin
  Result := 0;
  for c in str do
    if not Character.IsWhiteSpace(c) then
      inc(Result);
end;

procedure TTelaCadastrarClientes.btnCadastrarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: TelaCadastrarClientes.close;
  end;
end;

procedure TTelaCadastrarClientes.btnCancelarClick(Sender: TObject);
begin
  TelaCadastrarClientes.close;
end;

procedure TTelaCadastrarClientes.btnCadastrarClick(Sender: TObject);
 var
    erro: boolean;
begin
  erro := true;
  //  CADASTRAR ----------------------------------------------------------------
  if codigo = 'Cadastrar' then
  begin
    try
      if contadorDeString(EditNome.text) < 3 then
      begin
        ShowMessage('O nome deve ser maior que 3 caracteres.');
        erro := false;
      end;

      if cpfE = 1 then
        if contadorDeString(EditCpf.Text) < 14 then
        begin
          if contadorDeString(EditCpf.Text) <> 3 then
          begin
            ShowMessage('CPF invalido. O CPF deve conter pelo menos 11 caracteres!');
            erro := false;
          end;
        end;

      if telefoneE = 1  then
      begin
         if contadorDeString(EditTelefone.Text) < 13 then
          begin
            if contadorDeString(EditTelefone.Text) <> 3 then
            begin
              ShowMessage('Este telefone é muito curte,'+#13+EditTelefone.Text+' esta certo? Se sim, por favor entre em contato com o suporte');
              erro := false;
            end
            else
            begin
              ShowMessage('Não esqueça de informar o Telefone.');
              erro := false;
            end;
          end
      end
      else
      begin
        ShowMessage('Não esqueça de informar o Telefone.');
        erro := false;
      end;

      if erro then
      begin
        case MessageDlg('Confira se os dados estão corretos'+
                          #13+'Nome: '+EditNome.Text+
                          #13+'CPF: '+EditCpf.text+
                          #13+'Endereço: '+EditEndereco.Text+
                          #13+'Telefone: '+EditTelefone.Text,
                          mtConfirmation, [mbOK, mbCancel], 0) of
          mrOK: begin
                  try
                    with ADOQueryCadastrarClientes do
                    begin
                      close;
                      sql.clear;
                      sql.Add('INSERT INTO CLIENTES VALUES');
                      sql.Add('('+QuotedStr(EditNome.Text) + ' , ');

                      if contadorDeString(EditCpf.Text) <> 3 then
                        sql.Add(QuotedStr(EditCpf.Text) + ' , ')
                      else
                        sql.Add(QuotedStr('')+' , ');

                      sql.Add(QuotedStr(EditEndereco.Text)+')');
                      ExecSQL;

                      close;
                      sql.clear;
                      sql.Add('SELECT ID FROM CLIENTES WHERE');
                      sql.Add('NOME = ' +QuotedStr(EditNome.Text)+' AND CPF = ');

                      if contadorDeString(EditCpf.Text) <> 3 then
                        sql.Add(QuotedStr(EditCpf.Text))
                      else
                        sql.Add(QuotedStr(''));

                      sql.add(' AND ENDERECO =' + QuotedStr(EditEndereco.Text));
                      open;
                    end;
                    try
                      with ADOQueryCadastrarTelefone do
                      begin
                        close;
                        sql.clear;
                        sql.Add('INSERT INTO TELEFONES VALUES');
                        sql.Add('('+ADOQueryCadastrarClientes.FieldByName('ID').AsString+' , '+ QuotedStr(EditTelefone.Text) +')');
                        ExecSQL;
                      end;
                    except
                       ShowMessage('Erro ao cadastrar o telefone.'+#13+'Por enquanto você pode cadastrar o telefone na tela de clientes.'+#13+' Por favor contate o suporte e detalhe a situação.');
                       erro := false;
                    end;
                  except
                    ShowMessage('Erro ao cadastrar o cliente.'+#13+' Por favor contate o suporte e detalhe a situação.');
                    erro := false;
                  end;
                end;
            mrCancel:
              erro := false;
          end;
      end;
    finally
      if erro then
      begin
        ShowMessage('Cliente cadastrado com sucesso!');
        TelaCadastrarClientes.close;
      end;
    end;
  end
  //  EDITAR -------------------------------------------------------------------
  else if codigo = 'Editar' then
  begin
    try
      if contadorDeString(EditNome.text) < 3 then
      begin
        ShowMessage('O nome deve ser maior que 3 caracteres.');
        erro := false;
      end;

      if cpfE = 1 then
        if contadorDeString(EditCpf.Text) < 14 then
        begin
          if contadorDeString(EditCpf.Text) <> 3 then
          begin
            ShowMessage('CPF invalido. O CPF deve conter pelo menos 11 caracteres!');
            erro := false;
          end;
        end;

      if erro then
      begin
        case MessageDlg('Confira se os dados estão corretos'+
                              #13+'Nome: '+EditNome.Text+
                              #13+'CPF: '+EditCpf.text+
                              #13+'Endereço: '+EditEndereco.Text, mtConfirmation, [mbOK, mbCancel], 0) of
          mrOk: begin
                  try
                    with ADOQueryCadastrarClientes do
                    begin
                      close;
                      sql.Clear;
                      sql.Add('UPDATE CLIENTES');
                      sql.Add('SET NOME = '+QuotedStr(EditNome.Text)+' , ENDERECO = '+QuotedStr(EditEndereco.Text)+' , CPF = ');
                      
                      if contadorDeString(EditCpf.Text) <> 3 then
                        sql.Add(QuotedStr(EditCpf.Text))
                      else
                        sql.Add(QuotedStr(''));
                        
                      sql.Add('WHERE ID = '+TelaClientes.ADOQueryClientes.FieldByName('ID').AsString);
                      ExecSQL;
                    end;
                  except
                    erro := false;
                    ShowMessage('Erro ao salvar a edição.'+#13+'Por favor contate o suporte e detalhe a situação.');
                  end;
                end;
          mrCancel:
            erro := false;
        end
      end;
    finally
      if erro then
      begin
        ShowMessage('Dados do cliente atualizados com sucesso!');
        TelaCadastrarClientes.Close;
      end;
    end;
  end
  // CADASTRAR TELEFONE --------------------------------------------------------
  else if codigo = 'CadastrarTelefone' then
  begin
    try
      try
        if telefoneE = 1  then
        begin
           if contadorDeString(EditTelefone.Text) < 13 then
            begin
              if contadorDeString(EditTelefone.Text) <> 3 then
              begin
                ShowMessage('Este telefone é muito curte,'+#13+EditTelefone.Text+' esta certo? Se sim, por favor entre em contato com o suporte');
                erro := false;
              end
              else
              begin
                ShowMessage('Não esqueça de informar o Telefone.');
                erro := false;
              end;
            end
        end
        else
        begin
          ShowMessage('Não esqueça de informar o Telefone.');
          erro := false;
        end;
      
        if erro then
        case MessageDlg('Confira se o telefone esta certo: '+EditTelefone.Text, mtConfirmation, [mbOK, mbCancel], 0) of
        mrOk:
          begin
            with ADOQueryCadastrarTelefone do
            begin
              close;
              sql.clear;
              sql.Add('INSERT INTO TELEFONES VALUES');
              sql.Add('('+TelaClientes.ADOQueryClientes.FieldByName('ID').AsString+' , '+ QuotedStr(EditTelefone.Text) +')');
              ExecSQL;
            end  
          end;
        mrCancel:
          erro := false;
        end;      
      except
        ShowMessage('Erro ao inserir o Telefone!'+#13+'Por favor contate o suporte e detalhe a situação.');
        erro := false
      end;
    finally
      if erro then
      begin
        ShowMessage('Telefone adicionado com sucesso!');
        TelaCadastrarClientes.Close;
      end;
    end;
  end;
end;

procedure TTelaCadastrarClientes.EditCpfChange(Sender: TObject);
begin
  cpfE:=1;
end;

procedure TTelaCadastrarClientes.EditNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
if (Key in ['0'..'9']) then
  begin
    Key := #0;
  end;
end;

procedure TTelaCadastrarClientes.EditTelefoneChange(Sender: TObject);
begin
  telefoneE := 1;
end;

procedure TTelaCadastrarClientes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #27: btnCancelar.click;
    #13: btnCadastrar.click;
  end;
end;

procedure TTelaCadastrarClientes.FormShow(Sender: TObject);
begin
  if codigo = 'Editar' then
  begin
    btnCadastrar.Caption := 'Salvar';

    EditNome.Text := TelaClientes.ADOQueryClientes.FieldByName('NOME').AsString;
    EditEndereco.Text := TelaClientes.ADOQueryClientes.FieldByName('ENDERECO').AsString;

    EditCpf.EditMask := '';
    EditCpf.Text := TelaClientes.ADOQueryClientes.FieldByName('CPF').AsString;

    EditCpf.Text:= stringReplace(EditCpf.Text, '.', '', []);
    EditCpf.Text:= stringReplace(EditCpf.Text, '.', '', []);
    EditCpf.Text:= stringReplace(EditCpf.Text, '-', '', []);
    
    EditCpf.EditMask := '999.999.999-99;1; ';
    
    label2.Enabled := false;
    label2.Visible := false;

    EditTelefone.Enabled := false;
    EditTelefone.Visible := false;
  end
  else if codigo = 'CadastrarTelefone' then
  begin
    btnCadastrar.Caption := 'Adicionar';
  
    label1.Enabled := false;
    label1.Visible := false;
    label3.Enabled := false;
    label3.Visible := false;
    label4.Enabled := false;
    label4.Visible := false;

    EditNome.Enabled := false;
    EditNome.Visible := false;
    EditEndereco.Enabled := false;
    EditEndereco.Visible := false;
    EditCpf.Enabled := false;
    EditCpf.Visible := false;

    panel1.Enabled := false;
    panel1.Visible := false;
    panel2.Align := alClient;
  end;
end;

end.
