//---------------------------------------------------------------------------

// This software is Copyright (c) 2021 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

unit View.NewForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  View.Main, FMX.Effects, FMX.Layouts, FMX.Ani, FMX.Objects,
  FMX.Controls.Presentation, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Edit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TNewFormFrame = class(TMainFrame)
    Panel1: TPanel;
    Label3: TLabel;
    Edit1: TEdit;
    Query: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TNewFormFrame.Button1Click(Sender: TObject);
begin
  inherited;

 memo1.Lines.text := '';

 RESTClient1.ResetToDefaults;
 RESTClient1.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
 RESTClient1.AcceptCharset := 'UTF-8, *;q=0.8';
 RESTClient1.BaseURL := 'http://api.marketstack.com/v1/eod';
 RESTClient1.HandleRedirects := True;
 RESTClient1.RaiseExceptionOn500 := False;

 //here is were we pass the access_key and additional parameters
 RESTRequest1.Resource := Format('?access_key=%s&symbols=%s', [edit1.Text, edit2.Text]);

 RESTRequest1.Client := RESTClient1;
 RESTRequest1.Response := RESTResponse1;
 RESTRequest1.SynchronizedEvents := False;

 RESTResponse1.ContentType := 'application/json';

 //RESTRequest1.Params[0].Value := ;

 //RESTResponse1.RootElement := ;

 RESTRequest1.Execute;

 //memo2.Lines := RESTResponse1.Headers;
 memo1.Lines.text := RESTResponse1.Content;

end;

initialization
  // Register frame
  RegisterClass(TNewFormFrame);
finalization
  // Unregister frame
  UnRegisterClass(TNewFormFrame);

end.
