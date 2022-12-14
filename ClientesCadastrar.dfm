object TelaCadastrarClientes: TTelaCadastrarClientes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Home/Clientes/Cadastrar_Cliente'
  ClientHeight = 200
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 144
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 67
      Width = 290
      Height = 18
      Margins.Left = 5
      Align = alTop
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 68
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 11
      Width = 290
      Height = 18
      Margins.Left = 5
      Margins.Top = 10
      Align = alTop
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 42
    end
    object EditEndereco: TEdit
      AlignWithMargins = True
      Left = 6
      Top = 91
      Width = 290
      Height = 26
      Margins.Left = 5
      Align = alTop
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'Endere'#231'o...'
    end
    object EditNome: TMaskEdit
      AlignWithMargins = True
      Left = 6
      Top = 35
      Width = 290
      Height = 26
      Margins.Left = 5
      Align = alTop
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      TextHint = 'Nome...'
      OnKeyPress = EditNomeKeyPress
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 144
    Width = 600
    Height = 56
    Align = alBottom
    TabOrder = 2
    object btnCadastrar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 85
      Height = 48
      Align = alLeft
      Caption = 'Cadastrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCadastrarClick
      OnKeyDown = btnCadastrarKeyDown
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 520
      Top = 4
      Width = 76
      Height = 48
      Align = alRight
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 300
    Top = 0
    Width = 300
    Height = 144
    Align = alRight
    TabOrder = 1
    object Label2: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 67
      Width = 285
      Height = 18
      Margins.Right = 10
      Align = alTop
      Caption = 'Telefone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 58
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 285
      Height = 18
      Margins.Top = 10
      Margins.Right = 10
      Align = alTop
      Caption = 'CPF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 33
    end
    object EditTelefone: TMaskEdit
      AlignWithMargins = True
      Left = 4
      Top = 91
      Width = 292
      Height = 26
      Align = alTop
      EditMask = '!\(99\)99999-9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentFont = False
      TabOrder = 1
      Text = '(  )     -    '
      TextHint = 'Telefone'
      OnChange = EditTelefoneChange
    end
    object EditCpf: TMaskEdit
      AlignWithMargins = True
      Left = 4
      Top = 35
      Width = 292
      Height = 26
      Align = alTop
      EditMask = '999.999.999-99;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentFont = False
      TabOrder = 0
      Text = '   .   .   -  '
      TextHint = 'CPF'
      OnChange = EditCpfChange
    end
  end
  object ADOQueryCadastrarClientes: TADOQuery
    Connection = TelaDeSenha.ADOConnection
    Parameters = <>
    Left = 404
    Top = 144
  end
  object ADOQueryCadastrarTelefone: TADOQuery
    Connection = TelaDeSenha.ADOConnection
    Parameters = <>
    Left = 260
    Top = 144
  end
end