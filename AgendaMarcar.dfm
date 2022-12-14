object TelaMarcaHorario: TTelaMarcaHorario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Home/Agenda/Marca_Horario'
  ClientHeight = 256
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  StyleElements = [seFont, seClient]
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 198
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 116
      Width = 420
      Height = 18
      Align = alTop
      Caption = 'Telefone'
      ExplicitWidth = 58
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 60
      Width = 420
      Height = 18
      Align = alTop
      Caption = 'Procedimento:'
      ExplicitWidth = 102
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 420
      Height = 18
      Align = alTop
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 53
    end
    object emTelefone: TMaskEdit
      AlignWithMargins = True
      Left = 4
      Top = 140
      Width = 420
      Height = 26
      Align = alTop
      ReadOnly = True
      TabOrder = 2
      Text = ''
    end
    object emProcedimento: TMaskEdit
      AlignWithMargins = True
      Left = 4
      Top = 84
      Width = 420
      Height = 26
      Align = alTop
      TabOrder = 0
      Text = ''
      TextHint = 'Informe o Procedimento.'
    end
    object emNome: TMaskEdit
      AlignWithMargins = True
      Left = 4
      Top = 28
      Width = 420
      Height = 26
      Align = alTop
      ReadOnly = True
      TabOrder = 1
      Text = 'Clique aqui para selecionar o Cliente'
      OnClick = emNomeClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 198
    Width = 428
    Height = 58
    Align = alBottom
    TabOrder = 1
    object sbtnCancelar: TSpeedButton
      AlignWithMargins = True
      Left = 344
      Top = 4
      Width = 80
      Height = 50
      Align = alRight
      Caption = 'Cancelar'
      OnClick = sbtnCancelarClick
    end
    object sbtnConfirmar: TSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 85
      Height = 50
      Align = alLeft
      Caption = 'Confirmar'
      ImageIndex = 1
      OnClick = sbtnConfirmarClick
    end
  end
  object ADOQueryMarcar: TADOQuery
    Connection = TelaDeSenha.ADOConnection
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'drop table #AGENDA_TEMP;'
      ''
      'CREATE TABLE #AGENDA_TEMP('
      #9'HORARIO DATETIME,'
      #9'NOME VARCHAR(64),'
      #9'PROCEDIMENTO VARCHAR(64),'
      #9'TELEFONE VARCHAR(64)'
      ');'
      ''
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 08:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 08:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 08:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 09:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 09:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 09:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 10:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 10:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 10:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 11:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 11:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 11:40'#39'), 102), NULL, NULL, NULL);'
      ''
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 13:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 13:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 13:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 14:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 14:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 14:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 15:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 15:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 15:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 16:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 16:20'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 16:40'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 17:00'#39'), 102), NULL, NULL, NULL);'
      
        'INSERT INTO  #AGENDA_TEMP VALUES (CONVERT(datetime, CONCAT(FORMA' +
        'T(GETDATE(), '#39'yyyy/MM/dd'#39'), '#39' 17:20'#39'), 102), NULL, NULL, NULL);'
      ''
      
        'SELECT FORMAT(T.HORARIO, '#39'hh:mm'#39') AS HORARIO, O.NOME, O.PROCEDIM' +
        'ENTO, O.TELEFONE FROM AGENDA AS O'
      
        'RIGHT JOIN #AGENDA_TEMP AS T ON FORMAT(T.HORARIO, '#39'dd/MM/yyyy, h' +
        'h:mm'#39') = FORMAT(O.HORARIO, '#39'dd/MM/yyyy, hh:mm'#39')'
      'WHERE FORMAT(T.HORARIO, '#39'dd/MM/yyyy'#39') = '#39'15/11/2022'#39)
    Left = 232
    Top = 200
  end
end
