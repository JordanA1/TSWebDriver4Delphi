unit uExampleTSWebDriver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,  System.IOUtils, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Buttons, System.JSON, REST.Json,

  TSWebDriver,
  TSWebDriver.IElement,
  TSWebDriver.Interfaces,
  TSWebDriver.By,
  TSWebDriver.IBrowser, My_Additional;

type
  TFrmMain = class(TForm)
    MemLog: TMemo;
    btnNavigateTo: TButton;
    btnExecuteScript: TButton;
    btnExample4: TButton;
    btnExample5: TButton;
    btnExample1: TButton;
    btnExample2: TButton;
    btnPbs: TButton;
    Button1: TButton;
    Label1: TLabel;
    MyBitBtn1: TMyBitBtn;
    pbsEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteScriptClick(Sender: TObject);
    procedure btnExample4Click(Sender: TObject);
    procedure btnExample5Click(Sender: TObject);
    procedure btnExample2Click(Sender: TObject);
    procedure btnPbsClick(Sender: TObject);
    procedure btnNavigateToClick(Sender: TObject);
    procedure btnExample1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pbsEditClick(Sender: TObject);
  private
    { Private declarations }
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
    FBy: TSBy;
    procedure Run(AProc: TProc; AUrl: string = ''; ACloseSection: Boolean = False ); // True);
    procedure ExampleLoginAndScrap;
    procedure ExampleDynamicElement;
    procedure PBS;
    procedure ExampleGitHubFollowers;
    procedure ExampleChromeSearch;
  public
   { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

Uses ShellAPi;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FDriver.Stop;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FDriver := TTSWebDriver.New.Driver();
  FDriver.Options.DriverPath('C:\chromedriver\chromedriver.exe');

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver
    .AddArgument('window-size', '1000,800')
    .AddArgument('user-data-dir', 'C:/Dev/Delphi/TSWebDriver4Delphi/example/cache');
  ShellExecute(0, 'open', 'C:\chromedriver\chromedriver.exe', '--port=9515', nil, SW_SHOWNORMAL);

  FDriver.Start();
end;

procedure TFrmMain.Run(AProc: TProc; AUrl: string = ''; ACloseSection: Boolean = False);
begin
  MemLog.Clear();

  FChromeDriver.NewSession();

  if not AUrl.IsEmpty then
    FChromeDriver.NavigateTo(AUrl);

  FChromeDriver.WaitForPageReady();

  AProc();

  if ACloseSection then
    FChromeDriver.CloseSession();
end;

procedure TFrmMain.btnExample1Click(Sender: TObject);
begin
  Self.Run(
    ExampleLoginAndScrap,
    'https://www.saucedemo.com'
  );
end;

procedure TFrmMain.btnExample2Click(Sender: TObject);
begin
  Self.Run(
    ExampleDynamicElement,
    'https://www.selenium.dev/selenium/web/dynamic.html'
  );
end;



procedure TFrmMain.PBS;
var
  LElement: ITSWebDriverElement;
  LElements: TTSWebDriverElementList;
begin
  LElement := FChromeDriver.FindElement(FBy.ClassName('eventBtn'));
  LElement.Click();
  FChromeDriver.WaitForPageReady();
//bejelentkez�s
  LElement := FChromeDriver.FindElement(FBy.Id('userId'));
  LElement.SendKeys('K14737/6');
  LElement := FChromeDriver.FindElement(FBy.Id('userPass'));
  LElement.SendKeys('Schwabo1');
  LElement := FChromeDriver.FindElement(FBy.Id('userPass'));
  LElement := FChromeDriver.FindElement(FBy.id('loginbutton'));
  LElement.Click();
  FChromeDriver.WaitForPageReady();
  LElement := FChromeDriver.FindElement(FBy.Id('headerSearchTextBox'));
  LElement.SendKeys('46042');
  LElement := FChromeDriver.FindElement(FBy.id('headerSearchButton'));
  LElement.Click();
  FChromeDriver.WaitForPageReady();

{

  FChromeDriver.FindElement(FBy.ID('search')).Click();
  FChromeDriver.WaitForSelector('.media');
  with FChromeDriver.FindElement(FBy.CssSelector('.media-content > span')) do
  begin
    MemLog.Lines.AddPair('GitHub bio', GetText());
  end;
}
end;

procedure TFrmMain.pbsEditClick(Sender: TObject);
var
  LElement: ITSWebDriverElement;
begin
  LElement := FChromeDriver.FindElement(FBy.Id('headerSearchTextBox'));
  LElement.SendKeys(pbsEdit.Text);
  LElement := FChromeDriver.FindElement(FBy.id('headerSearchButton'));
  LElement.Click();
  FChromeDriver.WaitForPageReady();
end;

procedure TFrmMain.btnPbsClick(Sender: TObject);
begin
  Self.Run(PBS, 'https://www.pbs-shop.hu/' );  //    'https://letcode.in/elements'
end;

procedure TFrmMain.btnExample4Click(Sender: TObject);
begin
  Self.Run(
    ExampleChromeSearch,
    'https://www.mercadolivre.com.br'
  );
end;

procedure TFrmMain.btnExample5Click(Sender: TObject);
begin
  Self.Run(
    ExampleGitHubFollowers,
    'https://gh-users-search.netlify.app'
  );
end;

procedure TFrmMain.btnExecuteScriptClick(Sender: TObject);
begin
  MemLog.Text :=
    FChromeDriver.ExecuteSyncScript(
      InputBox('Script', '', 'return document.title'));
end;

procedure TFrmMain.btnNavigateToClick(Sender: TObject);
begin
  Self.Run(procedure
          begin
            FChromeDriver.NavigateTo(
              InputBox('Url', '', 'https://github.com/GabrielTrigo'));
          end,
  '', False);
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  Self.Run(
    procedure
    var
      LCheckbox: ITSWebDriverElement;
    begin
      LCheckbox := FChromeDriver.FindElement(FBy.XPath('//input[@id=''checky'']'));

      MemLog.Lines.Append(LCheckbox.GetAttribute('checked'));
      LCheckbox.Click();
      MemLog.Lines.Append(LCheckbox.GetAttribute('checked'));
    end,
    'file:///' + TPath.GetFullPath('..\..\test\mocks\formPage.html').Replace('\', '/')
  );
end;


procedure TFrmMain.ExampleChromeSearch;
var
  LElement: ITSWebDriverElement;
  LElements: TTSWebDriverElementList;
begin
  try
    LElement := FChromeDriver.FindElement(FBy.Name('as_word'));

    LElement.SendKeys('Macbook');
    // Send Enter key code > https://www.w3.org/TR/webdriver2/#element-send-keys
    LElement.SendKeys('\uE007');

    FChromeDriver.WaitForPageReady();

    LElements := FChromeDriver.FindElements(FBy.ClassName('ui-search-layout__item'));

    MemLog.Lines.Append('I finded ' + LElements.Count.ToString() + ' items');

    for LElement in LElements do
      with MemLog.Lines do
      begin
        AddPair('Name',  LElement.FindElement(FBy.TagName('h2')).GetText());
        AddPair('Price', LElement.FindElement(FBy.ClassName('ui-search-price__second-line')).GetText());
        Append('-------------------------');
      end;
  finally
    FreeAndNil(LElements);
  end;
end;

procedure TFrmMain.ExampleDynamicElement;
var
  LElement: ITSWebDriverElement;
begin
  LElement := FChromeDriver.FindElement(FBy.Id('adder'));

  LElement.Click();

  FChromeDriver.WaitForSelector('#box0');

  LElement := FChromeDriver.FindElement(FBy.Id('box0'));

  with MemLog.Lines do
  begin
    AddPair('Displayed', BoolToStr(LElement.Displayed(), True)).Add('');
    AddPair('Property style', LElement.GetProperty('style')).Add('');
    AddPair('Property innerHtml', LElement.GetProperty('innerHtml')).Add('');
    AddPair('CssValue "display"', LElement.GetCssValue('display')).Add('');
    AddPair('CssValue "width"', LElement.GetCssValue('width')).Add('');
    AddPair('CssValue "background-color"', LElement.GetCssValue('background-color')).Add('');
    AddPair('GetText', LElement.GetText()).Add('');
    AddPair('GetTagName', LElement.GetTagName()).Add('');
    AddPair('GetEnabled', BoolToStr(LElement.GetEnabled, True)).Add('');
    AddPair('GetPageSource', FChromeDriver.GetPageSource()).Add('');
  end;
end;


procedure TFrmMain.ExampleGitHubFollowers;
var
  LElement: ITSWebDriverElement;
  LElements: TTSWebDriverElementList;
begin
  LElements := FChromeDriver.FindElements(FBy.CssSelector('.followers > article'));

  for LElement in LElements do
    with MemLog.Lines do
    begin
      AddPair('Name', LElement.FindElement(FBy.TagName('h4')).GetText());
      AddPair('Link', LElement.FindElement(FBy.TagName('a')).GetText());
      Append('-------------------------');
    end;

  FreeAndNil(LElements);
end;

procedure TFrmMain.ExampleLoginAndScrap;
var
  LElement: ITSWebDriverElement;
  LElements: TTSWebDriverElementList;
begin
  try
    FChromeDriver.FindElement(FBy.Name('user-name')).SendKeys('standard_user');
    FChromeDriver.FindElement(FBy.ID('password')).SendKeys('secret_sauce');
    FChromeDriver.FindElement(FBy.Name('login-button')).Click();

    LElements := FChromeDriver.FindElements(FBy.ClassName('inventory_item'));

    for LElement in LElements do
      with MemLog.Lines do
      begin
        AddPair('Name', LElement.FindElement(FBy.ClassName('inventory_item_name')).GetText());
        AddPair('Description', LElement.FindElement(FBy.ClassName('inventory_item_desc')).GetText());
        AddPair('Price', LElement.FindElement(FBy.ClassName('inventory_item_price')).GetText());
        Append('-------------------------');
      end;
  finally
    FreeAndNil(LElements);
  end;
end;

end.

