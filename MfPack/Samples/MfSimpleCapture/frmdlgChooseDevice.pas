// FactoryX
//
// Copyright �2003 - 2019 by FactoryX, Netherlands/Australia
//
// Project: Media Foundation - MFPack - Samples
// Project location: http://sourceforge.net/projects/MFPack
// Module: frmdlgChooseDevice.pas
// Kind: Pascal Unit
// Release date: 08-02-2018
// Language: ENU
//
// Revision Version: 3.1.2
//
// Description: This is the basic class of MfSimpleCapture,
//              containing the necessary methodes to capture media streams.
//
// Company: FactoryX
// Intiator(s): Tony (maXcomX), Peter (OzShips)
// Contributor(s): Tony Kalf (maXcomX),
//                 Peter Larson (ozships)
//
//------------------------------------------------------------------------------
// CHANGE LOG
// Date       Person              Reason
// ---------- ------------------- ----------------------------------------------
// 28/06/2022 All                 Mercury release  SDK 10.0.22621.0 (Windows 11)
//------------------------------------------------------------------------------
//
// Remarks: Requires Windows 7 or higher.
//
// Related objects: -
// Related projects: MfPackX312
// Known Issues: -
//
// Compiler version: 23 up to 35
// SDK version: 10.0.22621.0
//
// Todo: -
//
// =============================================================================
// Source: Parts of CPreview Examples.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//==============================================================================
//
// LICENSE
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// https://www.mozilla.org/en-US/MPL/2.0/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
//
// Users may distribute this source code provided that this header is included
// in full at the top of the file.
//
//==============================================================================
unit frmdlgChooseDevice;

interface

uses
  {Winapi}
  Winapi.Windows,
  {System}
  System.SysUtils,
  System.Classes,
  {Vcl}
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  {MediaFoundationApi}
  WinApi.MediaFoundationApi.MfUtils,
  WinApi.MediaFoundationApi.MfIdl,
  WinApi.MediaFoundationApi.MfObjects,
  WinApi.MediaFoundationApi.MfMetLib,
  {Application}
  MfDeviceCaptureClass;

type
  TdlgChooseDevice = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    Bevel1: TBevel;
    cbxCaptureDevices: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
     dpa: TDevicePropertiesArray;
  end;

var
  dlgChooseDevice: TdlgChooseDevice;

implementation

{$R *.dfm}

procedure TdlgChooseDevice.butCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TdlgChooseDevice.butOkClick(Sender: TObject);
var
  hr: HRESULT;
  _i: Integer;

begin
  hr := S_OK;
  butOk.Enabled := False;
  for _i:= Low(dpa) to High(dpa) do
    begin
      if (dpa[_i].sFriendlyName = cbxCaptureDevices.Text) then
        begin
          hr := MfDeviceCapture.SetDevice(dpa[_i]);
          butOk.Enabled := True;
          Break;
        end;
    end;

  if FAILED(hr) then
    GetLastError();

  Close();
end;


procedure TdlgChooseDevice.FormShow(Sender: TObject);
var
  hr: HRESULT;
  _i: Integer;

begin
  cbxCaptureDevices.Clear;
  butOk.Enabled:= False;

  hr := EnumCaptureDeviceSources(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_GUID,
                                 dpa);

  if SUCCEEDED(hr) then
    begin
      for _i:= Low(dpa) to High(dpa) do
        cbxCaptureDevices.Items.Add(dpa[_i].sFriendlyName);

      cbxCaptureDevices.ItemIndex := 0;
      butOk.Enabled := True;
    end
  else
   begin
     cbxCaptureDevices.Items.Append('COULD NOT FIND A DEVICE');
     cbxCaptureDevices.ItemIndex := 0;
   end;
end;

end.
