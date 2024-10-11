object Form1: TForm1
  Left = 249
  Top = 109
  Width = 765
  Height = 532
  HorzScrollBar.Position = 1
  Caption = 'Windows'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    757
    489)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = -1
    Top = 365
    Width = 758
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    ParentShowHint = False
    Shape = bsSpacer
    ShowHint = False
  end
  object Panel1: TPanel
    Left = -1
    Top = 0
    Width = 758
    Height = 365
    Caption = 'Panel1'
    TabOrder = 1
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 756
      Height = 363
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      BackWall.Pen.Visible = False
      MarginBottom = 15
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlack
      Title.Font.Height = -11
      Title.Font.Name = 'Arial'
      Title.Font.Style = []
      Title.Text.Strings = (
        'Source signal')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMaximum = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.Increment = 0.100000000000000000
      BottomAxis.Maximum = 1.000000000000000000
      BottomAxis.Minimum = -1.000000000000000000
      Frame.Visible = False
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.ExactDateTime = False
      LeftAxis.Increment = 0.200000000000000000
      LeftAxis.Maximum = 1.000000000000000000
      LeftAxis.Minimum = -1.000000000000000000
      View3D = False
      View3DOptions.Elevation = 344
      View3DOptions.Perspective = 19
      Align = alClient
      TabOrder = 0
      object Series1: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clMaroon
        Title = 'Rectangular'
        Dark3D = False
        LinePen.Color = clMaroon
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Width = 2
        Pointer.Style = psDiagCross
        Pointer.Visible = True
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
        SeriesColor = clYellow
        Title = 'Triangle'
        Dark3D = False
        LinePen.Color = clYellow
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.HorizSize = 8
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clYellow
        Pointer.Pen.Width = 2
        Pointer.Style = psTriangle
        Pointer.VertSize = 8
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series3: TLineSeries
        Marks.ArrowLength = 8
        Marks.BackColor = clBlack
        Marks.Frame.Color = -1
        Marks.Visible = False
        SeriesColor = clBlue
        Title = 'Gauss'
        Dark3D = False
        LinePen.Color = clBlue
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clBlue
        Pointer.Pen.Width = 3
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series4: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlack
        Title = 'Blackman'
        Dark3D = False
        LinePen.Width = 4
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
      object Series5: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clFuchsia
        Title = 'Cos ^ 2'
        Dark3D = False
        LinePen.Color = 8388863
        LinePen.Width = 2
        Pointer.Brush.Color = clWhite
        Pointer.HorizSize = 8
        Pointer.InflateMargins = True
        Pointer.Pen.Color = 8388863
        Pointer.Pen.Width = 2
        Pointer.Style = psRectangle
        Pointer.VertSize = 8
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series6: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clLime
        Title = 'Hamming'
        Dark3D = False
        LinePen.Color = clLime
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clLime
        Pointer.Pen.Width = 2
        Pointer.Style = psStar
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series7: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clAqua
        Title = 'Hanning'
        Dark3D = False
        LinePen.Color = clAqua
        LinePen.Width = 3
        Pointer.HorizSize = 1
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clAqua
        Pointer.Style = psRectangle
        Pointer.VertSize = 3
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series8: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'Kaisser'
        Dark3D = False
        LinePen.Color = clRed
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.HorizSize = 45
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clRed
        Pointer.Pen.Width = 3
        Pointer.Style = psCircle
        Pointer.VertSize = 45
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series9: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'Lanczos'
        Dark3D = False
        LinePen.Color = clRed
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Width = 3
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series10: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clRed
        Title = 'Tukey'
        Dark3D = False
        LinePen.Color = clRed
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clBlue
        Pointer.Pen.Width = 3
        Pointer.Style = psDiamond
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series11: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = 12615935
        Title = 'BlackmanHarris'
        Dark3D = False
        LinePen.Color = 12615935
        LinePen.Width = 3
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clGreen
        Pointer.Pen.Width = 3
        Pointer.Style = psDiamond
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series12: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clBlack
        Title = 'FlatTop'
        Dark3D = False
        LinePen.Width = 4
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clBlue
        Pointer.Pen.Width = 3
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series13: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        Title = 'Bohman'
        Dark3D = False
        LinePen.Color = clGreen
        LinePen.Width = 4
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Width = 3
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series14: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clMaroon
        Title = 'Nuttall'
        Dark3D = False
        LinePen.Color = clMaroon
        LinePen.Width = 4
        Pointer.Brush.Color = clWhite
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clYellow
        Pointer.Pen.Width = 3
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series15: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = -1
        Title = 'BlackmanNuttall'
        Dark3D = False
        LinePen.Width = 4
        Pointer.Brush.Color = clMaroon
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clMaroon
        Pointer.Pen.Width = 3
        Pointer.Style = psRectangle
        Pointer.Visible = True
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object Series16: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clGreen
        Title = 'Parzen'
        Dark3D = False
        LinePen.Color = clGreen
        LinePen.Width = 4
        Pointer.Brush.Color = clPurple
        Pointer.InflateMargins = True
        Pointer.Pen.Color = clPurple
        Pointer.Pen.Width = 3
        Pointer.Style = psRectangle
        Pointer.Visible = True
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
  object Panel2: TPanel
    Left = -1
    Top = 375
    Width = 758
    Height = 114
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 756
      Height = 112
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 27
        Width = 44
        Height = 13
        Caption = 'Windows'
        Color = clBtnFace
        ParentColor = False
      end
      object Label2: TLabel
        Left = 24
        Top = 76
        Width = 29
        Height = 13
        Caption = 'Orden'
        Color = clBtnFace
        ParentColor = False
        Transparent = True
      end
      object ComboBox1: TComboBox
        Left = 80
        Top = 22
        Width = 112
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Rectangular'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Rectangular'
          'Triangle'
          'Gauss'
          'BlackMan'
          'Cos^2'
          'Hamming'
          'Hanning'
          'Kaisser'
          'Lanczos'
          'Tukey'
          'BlackmanHarris'
          'FlatTop'
          'Bohman'
          'Nuttall'
          'BlackmanNuttall'
          'Parzen')
      end
      object btClear: TButton
        Left = 296
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 1
        OnClick = btClearClick
      end
      object BtnClose: TButton
        Left = 296
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Close'
        TabOrder = 2
        OnClick = BtnCloseClick
      end
      object spOrder: TSpinEdit
        Left = 80
        Top = 72
        Width = 80
        Height = 22
        MaxValue = 999999
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
    end
  end
  object WinBlackman1: TWinBlackman
    A1 = 0.426590000000000000
    A2 = 0.496560000000000000
    A3 = 0.076848000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 504
    Top = 176
  end
  object WinBlackmanHarris1: TWinBlackmanHarris
    A1 = 0.358750000000000000
    A2 = 0.488290000000000000
    A3 = 0.141280000000000000
    A4 = 0.011680000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 424
    Top = 176
  end
  object WinBlackmanNuttall1: TWinBlackmanNuttall
    BNA0 = 0.489177500000000000
    BNA1 = 0.489177500000000000
    BNA2 = 0.136599500000000000
    BNA3 = 0.010641100000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 376
    Top = 248
  end
  object WinBohman1: TWinBohman
    Order = 0
    Gain = 1.000000000000000000
    Left = 344
    Top = 208
  end
  object WinCos21: TWinCos2
    Order = 0
    Gain = 1.000000000000000000
    Left = 464
    Top = 176
  end
  object WinFlatTop1: TWinFlatTop
    A1 = 1.000000000000000000
    A2 = 1.930000000000000000
    A3 = 1.290000000000000000
    A4 = 0.388000000000000000
    A5 = 0.032000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 384
    Top = 176
  end
  object WinGauss1: TWinGauss
    GA1 = 3.000000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 344
    Top = 248
  end
  object WinHamming1: TWinHamming
    A1 = 0.543478260999999900
    Order = 0
    Gain = 1.000000000000000000
    Left = 424
    Top = 208
  end
  object WinHanning1: TWinHanning
    A1 = 0.500000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 384
    Top = 208
  end
  object WinKaiser1: TWinKaiser
    Order = 0
    Gain = 1.000000000000000000
    Left = 464
    Top = 208
  end
  object WinLanczos1: TWinLanczos
    Order = 0
    Gain = 1.000000000000000000
    Left = 352
    Top = 176
  end
  object WinNuttall1: TWinNuttall
    A0 = 0.355768000000000000
    A1 = 0.487396000000000000
    A2 = 0.144232000000000000
    A3 = 0.012604000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 512
    Top = 248
  end
  object WinParzen1: TWinParzen
    Left = 504
    Top = 208
  end
  object WinRectangular1: TWinRectangular
    RA1 = 1.000000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 472
    Top = 248
  end
  object WinTriangle1: TWinTriangle
    Order = 0
    Gain = 1.000000000000000000
    Left = 440
    Top = 248
  end
  object WinTukey1: TWinTukey
    A1 = 0.500000000000000000
    Order = 0
    Gain = 1.000000000000000000
    Left = 408
    Top = 248
  end
end
