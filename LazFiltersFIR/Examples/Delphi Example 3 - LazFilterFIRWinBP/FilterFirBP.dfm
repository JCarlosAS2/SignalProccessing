object Form1: TForm1
  Left = 219
  Top = 115
  Width = 768
  Height = 603
  Caption = 'FilterFirWinBP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 365
    Width = 758
    Height = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 366
    Width = 758
    Height = 180
    TabOrder = 0
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 1
      Width = 758
      Height = 178
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 6
        Width = 201
        Height = 160
        Caption = 'Source'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lFreq1: TLabel
          Left = 25
          Top = 69
          Width = 21
          Height = 13
          Caption = 'Freq'
        end
        object lAmp: TLabel
          Left = 24
          Top = 99
          Width = 21
          Height = 13
          Caption = 'Amp'
        end
        object lSampleRate: TLabel
          Left = 24
          Top = 132
          Width = 67
          Height = 13
          Caption = 'F.SampleRate'
        end
        object Label4: TLabel
          Left = 113
          Top = 44
          Width = 29
          Height = 13
          Caption = 'Signal'
        end
        object rbSin: TRadioButton
          Left = 9
          Top = 18
          Width = 44
          Height = 17
          Caption = 'Sine'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbSquare: TRadioButton
          Left = 57
          Top = 18
          Width = 60
          Height = 17
          Caption = 'Square'
          TabOrder = 1
        end
        object rbTriangle: TRadioButton
          Left = 117
          Top = 18
          Width = 65
          Height = 17
          Caption = 'Triangle'
          TabOrder = 2
        end
        object SpinEditFreq: TSpinEdit
          Left = 112
          Top = 65
          Width = 57
          Height = 22
          MaxValue = 20000
          MinValue = 0
          TabOrder = 3
          Value = 30
        end
        object SpinEdit2: TSpinEdit
          Left = 112
          Top = 96
          Width = 57
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 4
          Value = 100
        end
        object SpinEdit3: TSpinEdit
          Left = 112
          Top = 128
          Width = 70
          Height = 22
          MaxValue = 44100
          MinValue = 0
          TabOrder = 5
          Value = 20000
        end
      end
      object GroupBox2: TGroupBox
        Left = 220
        Top = 6
        Width = 293
        Height = 160
        Caption = 'Filter Properties'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lWin: TLabel
          Left = 192
          Top = 15
          Width = 44
          Height = 13
          Caption = 'Windows'
        end
        object lOrden: TLabel
          Left = 8
          Top = 36
          Width = 29
          Height = 13
          Caption = 'Orden'
        end
        object lFreqCurt: TLabel
          Left = 8
          Top = 67
          Width = 46
          Height = 13
          Caption = 'FreqCurt1'
        end
        object lGain: TLabel
          Left = 10
          Top = 130
          Width = 22
          Height = 13
          Caption = 'Gain'
        end
        object lFreqCurt2: TLabel
          Left = 8
          Top = 97
          Width = 46
          Height = 13
          Caption = 'FreqCurt2'
        end
        object CBoxWin: TComboBox
          Left = 168
          Top = 33
          Width = 110
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Blackman'
            'BlackmanHarris'
            'BlackmanNuttall'
            'Bohman'
            'Cos2'
            'FlatTop'
            'Gauss'
            'Hamming'
            'Hanning'
            'Kaiser'
            'Lanczos'
            'Nuttall'
            'Parzen'
            'Rectangular'
            'Triangular'
            'Tukey')
        end
        object SpinEdit1: TSpinEdit
          Left = 72
          Top = 33
          Width = 57
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object SpinEdit4: TSpinEdit
          Left = 72
          Top = 63
          Width = 57
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 2500
        end
        object SpinEdit5: TSpinEdit
          Left = 73
          Top = 129
          Width = 57
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 1
        end
        object SpinEdit6: TSpinEdit
          Left = 72
          Top = 94
          Width = 57
          Height = 22
          MaxValue = 20000
          MinValue = 0
          TabOrder = 4
          Value = 5000
        end
      end
      object btnClose: TButton
        Left = 408
        Top = 96
        Width = 75
        Height = 41
        Caption = 'Close'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 550
    Width = 760
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 758
    Height = 364
    Caption = 'Panel1'
    TabOrder = 2
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 758
      Height = 363
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      MarginBottom = 15
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlack
      Title.Font.Height = -11
      Title.Font.Name = 'Arial'
      Title.Font.Style = []
      Title.Text.Strings = (
        'Source')
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.ExactDateTime = False
      LeftAxis.Increment = 0.200000000000000000
      LeftAxis.Maximum = 1.000000000000000000
      LeftAxis.Minimum = -1.000000000000000000
      View3D = False
      TabOrder = 0
      object Series1: TFastLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlue
        Title = 'Input'
        LinePen.Color = clBlue
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'OutPut (Filtered)'
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
  end
  object WinTukey1: TWinTukey
    A1 = 0.500000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 72
    Top = 56
  end
  object WinTriangle1: TWinTriangle
    Order = 0
    Gain = 1.000000000000000000
    Left = 120
    Top = 56
  end
  object WinRectangular1: TWinRectangular
    RA1 = 1.000000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 168
    Top = 56
  end
  object WinParzen1: TWinParzen
    Left = 216
    Top = 56
  end
  object WinNuttall1: TWinNuttall
    A0 = 0.355768000000000000
    A1 = 0.487396000000000000
    A2 = 0.144232000000000000
    A3 = 0.012604000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 264
    Top = 56
  end
  object WinLanczos1: TWinLanczos
    Order = 0
    Gain = 1.000000000000000000
    Left = 72
    Top = 96
  end
  object WinKaiser1: TWinKaiser
    Order = 0
    Gain = 1.000000000000000000
    Left = 120
    Top = 96
  end
  object WinHanning1: TWinHanning
    A1 = 0.500000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 168
    Top = 96
  end
  object WinHamming1: TWinHamming
    A1 = 0.543478260999999900
    Order = 0
    Gain = 1.000000000000000000
    Left = 216
    Top = 96
  end
  object WinGauss1: TWinGauss
    GA1 = 3.000000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 264
    Top = 96
  end
  object WinFlatTop1: TWinFlatTop
    A1 = 1.000000000000000000
    A2 = 1.930000000000000000
    A3 = 1.290000000000000000
    A4 = 0.388000000000000000
    A5 = 0.032000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 72
    Top = 136
  end
  object WinCos21: TWinCos2
    Order = 0
    Gain = 1.000000000000000000
    Left = 120
    Top = 136
  end
  object WinBohman1: TWinBohman
    Order = 0
    Gain = 1.000000000000000000
    Left = 168
    Top = 136
  end
  object WinBlackmanNuttall1: TWinBlackmanNuttall
    BNA0 = 0.489177500000000000
    BNA1 = 0.489177500000000000
    BNA2 = 0.136599500000000000
    BNA3 = 0.010641100000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 216
    Top = 136
  end
  object WinBlackmanHarris1: TWinBlackmanHarris
    A1 = 0.358750000000000000
    A2 = 0.488290000000000000
    A3 = 0.141280000000000000
    A4 = 0.011680000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 264
    Top = 136
  end
  object WinBlackman1: TWinBlackman
    A1 = 0.426590000000000000
    A2 = 0.496560000000000000
    A3 = 0.076848000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 72
    Top = 176
  end
  object Timer1: TTimer
    Left = 336
    Top = 56
  end
end
