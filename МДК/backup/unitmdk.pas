unit unitmdk;

{$mode objfpc}{$H+}

interface

uses

     Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
     Buttons;

type
  PStudentNode = ^TStudentNode;
  TStudentNode = record
    Name: String;
    Surname: String;
    Group: String;
    Address: String;
    Next: PStudentNode;
  end;

  { TKoww }

  TKoww = class(TForm)
    ButtonClear: TButton;
    EditName: TEdit;
    EditSurname: TEdit;
    EditGroup: TEdit;
    EditAddress: TEdit;
    Image1: TImage;
    lb_Ima: TLabel;
    lb_Fam: TLabel;
    lb_Grup: TLabel;
    lp_Addres: TLabel;
    ListBoxStudents: TListBox;
    ButtonAdd: TButton;
    ButtonShow: TButton;
    ButtonDelete: TButton;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
  private
    { private declarations }
    StudentList: PStudentNode;
  public
    { public declarations }
  end;

var
  Koww: TKoww;

implementation

{$R *.lfm}

procedure TKoww.ButtonAddClick(Sender: TObject);
var
  NewNode: PStudentNode;
begin
  New(NewNode);

  NewNode^.Name := EditName.Text;
  NewNode^.Surname := EditSurname.Text;
  NewNode^.Group := EditGroup.Text;
  NewNode^.Address := EditAddress.Text;

  NewNode^.Next := StudentList;
  StudentList := NewNode;
end;

procedure TKoww.ButtonClearClick(Sender: TObject);
begin
  if (EditName.Text = '') and (EditSurname.Text= '') and (EditGroup.Text = '') and (EditAddress.Text= '') then begin
    Showmessage('И так все пусто(')
    end
  else
  EditName.Clear;
  EditSurname.Clear;
  EditGroup.Clear;
  EditAddress.Clear;
end;

procedure TKoww.ButtonShowClick(Sender: TObject);
var
  CurrentNode: PStudentNode;
begin
  ListBoxStudents.Clear;

  CurrentNode := StudentList;
  while CurrentNode <> nil do
  begin
    ListBoxStudents.Items.Add(
      'Фамилия: ' + CurrentNode^.Surname + ' ' +
      'Имя: ' + CurrentNode^.Name + ' ' +
      'Группа: ' + CurrentNode^.Group + ' ' +
      'Адрес: ' + CurrentNode^.Address
);
    CurrentNode := CurrentNode^.Next;
  end;
end;

procedure TKoww.ButtonDeleteClick(Sender: TObject);
var
  CurrentNode, PreviousNode: PStudentNode;
  Index: Integer;
begin
  if ListBoxStudents.ItemIndex >= 0 then
  begin
    if ListBoxStudents.ItemIndex = 0 then
    begin
      CurrentNode := StudentList;
      StudentList := CurrentNode^.Next;
    end
    else
    begin
      PreviousNode := StudentList;
      CurrentNode := StudentList^.Next;

      Index := ListBoxStudents.ItemIndex;

      while (CurrentNode <> nil) and (Index > 1) do
      begin
        Dec(Index);
        PreviousNode := CurrentNode;
        CurrentNode := CurrentNode^.Next;
      end;


        PreviousNode^.Next := CurrentNode^.Next;

    end;

    Dispose(CurrentNode);

    ButtonShowClick(Sender);
  end
  else
  begin

    ShowMessage('Выберите элемент для удаления.');
  end;
end;




end.

