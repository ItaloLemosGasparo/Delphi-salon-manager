unit Home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXPickers, Vcl.ComCtrls, Vcl.Buttons, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  THomeScrean = class(TForm)
    Panel16: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PainelBotoes: TPanel;
    btnFinaceiro: TButton;
    btnAgenda: TButton;
    btnCientes: TButton;
    TimerHoras: TTimer;
    Panel1: TPanel;
    MonthCalendar1: TMonthCalendar;
    LabelHoras: TLabel;
    sbtnCadastrarCliente: TSpeedButton;
    sbtnInfo: TSpeedButton;
    imgcHome: TImageCollection;
    vimgLInfo: TVirtualImageList;
    vimgLInfoCadastrarCli: TVirtualImageList;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerHorasTimer(Sender: TObject);
    procedure btnAgendaClick(Sender: TObject);
    procedure btnCientesClick(Sender: TObject);
    procedure sbtnCadastrarClienteClick(Sender: TObject);
    procedure sbtnInfoMouseEnter(Sender: TObject);
    procedure sbtnInfoMouseLeave(Sender: TObject);
    procedure sbtnCadastrarClienteMouseEnter(Sender: TObject);
    procedure sbtnCadastrarClienteMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HomeScrean: THomeScrean;

implementation

{$R *.dfm}

uses Senha, Agenda, Clientes, ClientesCadastrar;



procedure THomeScrean.btnAgendaClick(Sender: TObject);
begin
  try
    TelaAgenda := TTelaAgenda.Create(self);
    TelaAgenda.ShowModal;
  finally
    TelaAgenda.free;
  end;
end;

procedure THomeScrean.btnCientesClick(Sender: TObject);
begin
  try
    TelaClientes := TTelaClientes.Create(self);
    TelaClientes.ShowModal;
  finally
    TelaClientes.free;
  end;
end;

procedure THomeScrean.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TelaDeSenha.close;
end;

procedure THomeScrean.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:
      case MessageDlg('Realmente deseja sair?', mtConfirmation, [mbOK, mbCancel], 0) of
        mrOk:
          begin
           HomeScrean.Close;
          end;
      end;

    VK_F1: sbtnCadastrarCliente.Click;

    VK_F2:
      begin
        try
          TelaAgenda := TTelaAgenda.Create(self);
          TelaAgenda.ShowModal;
        finally
          TelaAgenda.free;
        end;
      end;

    VK_F5: sbtnInfo.Click;
  end;
end;

procedure THomeScrean.FormShow(Sender: TObject);
begin
  TelaDeSenha.Visible := false;
  LabelHoras.Caption := 'Agora são:'+ FormatDateTime('HH:MM',time)+'';
end;

procedure THomeScrean.sbtnCadastrarClienteClick(Sender: TObject);
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
  end;
end;

procedure THomeScrean.sbtnCadastrarClienteMouseEnter(Sender: TObject);
begin
  //Botão CadastrarCli
  sbtnCadastrarCliente.AlignWithMargins:=false;
  sbtnCadastrarCliente.Width :=56;

  vimgLInfoCadastrarCli.Height := 56;
  vimgLInfoCadastrarCli.Width := 56;

  sbtnCadastrarCliente.ImageName := 'CADD56';
end;

procedure THomeScrean.sbtnCadastrarClienteMouseLeave(Sender: TObject);
begin
//Botão CadastrarCli
  sbtnCadastrarCliente.AlignWithMargins:=true;
  sbtnCadastrarCliente.Width :=50;

  vimgLInfoCadastrarCli.Height := 50;
  vimgLInfoCadastrarCli.Width := 50;

  sbtnCadastrarCliente.ImageName := 'CADD50';
end;

procedure THomeScrean.sbtnInfoMouseEnter(Sender: TObject);
begin
  //Botão Info
  sbtnInfo.AlignWithMargins:=false;
  sbtnInfo.Width :=56;

  vimgLinfo.Height := 56;
  vimgLinfo.Width := 56;

  sbtnInfo.ImageName := 'Info56';
end;

procedure THomeScrean.sbtnInfoMouseLeave(Sender: TObject);
begin
  //Botão Info
  sbtnInfo.AlignWithMargins:=true;
  sbtnInfo.Width :=50;

  vimgLinfo.Height := 50;
  vimgLinfo.Width := 50;

  sbtnInfo.ImageName := 'Info50';
end;

procedure THomeScrean.TimerHorasTimer(Sender: TObject);
begin
  LabelHoras.Caption := 'Agora são: '+ FormatDateTime('HH:MM',time);
end;

end.
