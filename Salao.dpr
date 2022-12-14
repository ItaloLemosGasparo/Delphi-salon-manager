program Salao;

uses
  Vcl.Forms,
  Senha in 'Senha.pas' {TelaDeSenha},
  Home in 'Home.pas' {HomeScrean},
  Agenda in 'Agenda.pas' {TelaAgenda},
  Clientes in 'Clientes.pas' {TelaClientes},
  ClientesCadastrar in 'ClientesCadastrar.pas' {TelaCadastrarClientes},
  AgendaMarcar in 'AgendaMarcar.pas' {TelaMarcaHorario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTelaDeSenha, TelaDeSenha);
  Application.CreateForm(THomeScrean, HomeScrean);
  Application.CreateForm(TTelaAgenda, TelaAgenda);
  Application.CreateForm(TTelaClientes, TelaClientes);
  Application.CreateForm(TTelaCadastrarClientes, TelaCadastrarClientes);
  Application.CreateForm(TTelaMarcaHorario, TelaMarcaHorario);
  Application.Run;
end.
