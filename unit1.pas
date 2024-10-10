unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }



  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;


  // Statistiques du joueur
type typejoueur = record

  nom : string[30];
  victoire : integer;
  defaite : integer;
  victoire_ia : integer;
  defaite_ia : integer;
  p_victoire : currency;
  nombre_coupM_victoire : currency;
  p_defaite : currency;
  p_victoire_ia : currency;
  nombre_coupM_victoire_ia : currency;
  p_defaite_ia : currency;
  nombre_partie_total : integer;
  nombre_partie_codeur : integer;
  nombre_partie_decodeur_ia : integer;
  nombre_partie_decodeur : integer;
  tour_gagnant : integer;
  tour_gagnant_ia : integer;
  end;


  // Variable fic pour enregistrer les stats des joueurs
var Fic : file of Typejoueur;

joueur : typejoueur;
posit : integer;





implementation

uses Unit2, Unit3, Unit4, Unit5;

{$R *.lfm}

{ TForm1 }
// Boutton codeur
procedure TForm1.Button1Click(Sender: TObject);
var i, j : integer;
begin
  form1.hide;
  form3.show;
  form3.BorderIcons := Form3.BorderIcons - [BiSystemMenu];

  form3.edit4.text:='';
  form3.edit4.enabled:=true;
  form3.button4.enabled:=false;
  form3.button3.enabled:=true;

  for j := 0 to 5 do
    begin
      for i := 0 to 11 do
        begin
          form3.stringgrid1.canvas.brush.color := clWhite;
          form3.stringgrid1.canvas.fillrect(form2.stringgrid1.cellRect(j,i));
          form3.stringgrid1.cells[j,i] := '';
        end;
    end;

end;


// Boutton décodeur
procedure TForm1.Button2Click(Sender: TObject);
var i, j : integer;
begin
  form1.hide;
  form2.show;
  form2.BorderIcons := Form2.BorderIcons - [BiSystemMenu];
  form2.button2.enabled := True;
  form2.label1.caption := 'Vous êtes décodeur, vous avez 10 essais pour trouver le code de l''IA. Bonne chance !';


  for j := 0 to 5 do
    begin
      for i := 0 to 11 do
        begin
          form2.stringgrid1.canvas.brush.color := clWhite;
          form2.stringgrid1.canvas.fillrect(form2.stringgrid1.cellRect(j,i));
          form2.stringgrid1.cells[j,i] := '';
        end;
    end;

  form2.StringGrid1.canvas.Brush.color := clBlack;
  for I := 0 to 5 do
    begin
      form2.stringgrid1.canvas.fillrect(form2.Stringgrid1.cellRect(I,11));
    end;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  form4.BorderIcons := Form4.BorderIcons - [BiSystemMenu];
  form1.hide;
  form4.show;
end;


// Bouton pour afficher statistiques   et division par 0
procedure TForm1.Button4Click(Sender: TObject);
begin
  form5.BorderIcons := Form5.BorderIcons - [BiSystemMenu];
  if (joueur.nombre_partie_decodeur > 0) then
     begin
          joueur.p_victoire := (joueur.victoire / joueur.nombre_partie_decodeur) * 100;
          joueur.p_defaite := (joueur.defaite / joueur.nombre_partie_decodeur) * 100;
     end;
  if (joueur.nombre_partie_decodeur_ia > 0) then
     begin
        joueur.p_victoire_ia := (joueur.victoire_ia / joueur.nombre_partie_decodeur_ia) * 100;
        joueur.p_defaite_ia := (joueur.defaite_ia / joueur.nombre_partie_decodeur_ia) * 100;
     end;

   if (joueur.victoire > 0) then
      begin
        joueur.nombre_coupM_victoire := joueur.tour_gagnant / joueur.victoire ;
      end;

   if (joueur.victoire_ia > 0) then
      begin
        joueur.nombre_coupM_victoire_ia := joueur.tour_gagnant_ia / joueur.victoire_ia ;
      end;


  form5.label26.caption := joueur.nom;
  form5.label15.caption := inttostr(joueur.victoire);
  form5.label16.caption := inttostr(joueur.defaite);
  form5.label17.caption := inttostr(joueur.victoire_ia);
  form5.label18.caption := inttostr(joueur.defaite_ia);
  form5.label19.caption := currtostr(joueur.p_victoire);
  form5.label20.caption := currtostr(joueur.p_defaite);
  form5.label21.caption := currtostr(joueur.p_victoire_ia);
  form5.label22.caption := currtostr(joueur.p_defaite_ia);
  form5.label23.caption := inttostr(joueur.nombre_partie_total);
  form5.label24.caption := inttostr(joueur.nombre_partie_codeur);
  form5.label25.caption := inttostr(joueur.nombre_partie_decodeur);
  form5.label30.caption := currtostr(joueur.nombre_coupM_victoire);
  form5.label31.caption := currtostr(joueur.nombre_coupM_victoire_ia);
  form5.label33.caption := inttostr(joueur.nombre_partie_decodeur_ia);
  write(fic, joueur);

  form1.hide;
  form5.show;
end;



// Bouton pour créer un nouveau joueur
procedure TForm1.Button5Click(Sender: TObject);
var trouve : boolean;

begin
  if (edit1.text <> '') then
     begin
          seek (fic, 0);
          trouve := false;
          while ((not eof(fic)) and (trouve = false)) do
                begin
                     read(fic, joueur);
                     if (joueur.nom = edit1.text) then
                        begin
                             trouve := true;
                             showmessage('Ce pseudo existe déjà. Veuillez entrez un autre.');
                        end;
                end;
          if (trouve = false) then
             begin
               joueur.nom := edit1.text;
               joueur.victoire := 0;
               joueur.defaite := 0;
               joueur.victoire_ia := 0;
               joueur.defaite_ia := 0;
               joueur.p_victoire := 0;
               joueur.p_defaite := 0;
               joueur.p_victoire_ia := 0;
               joueur.p_defaite_ia := 0;
               joueur.nombre_partie_total := 0;
               joueur.nombre_partie_codeur := 0;
               joueur.nombre_partie_decodeur := 0;
               joueur.nombre_coupM_victoire := 0;
               joueur.nombre_coupM_victoire_ia := 0;
               joueur.nombre_partie_decodeur_ia := 0;
               joueur.tour_gagnant := 0;
               joueur.tour_gagnant_ia := 0;
               write(fic, joueur);
               posit :=  filepos(Fic);

               form1.caption := 'Mastermind - joueur : ' + edit1.text;
               form2.caption := 'Mastermind (décodeur) - joueur : ' + edit1.text;
               form3.caption := 'Mastermind (codeur) - joueur : ' + edit1.text;
               form4.caption := 'Mastermind - règles - joueur : ' + edit1.text;
               form5.caption := 'Mastermind - statistiques - joueur : ' + edit1.text;

               showmessage('Nouveau joueur : ' + edit1.text + ' enregistré !');

               button1.enabled := True;
               button2.enabled := True;
               button4.enabled := True;
             end;
     end;

  if (edit1.text = '') then
     begin
          showmessage('Veuillez entrez un pseudo svp avec les caractères suivants : (A..Z) et (a..z)');
     end;
end;

// Bouton charger un joueur
procedure TForm1.Button6Click(Sender: TObject);
var trouve : boolean;

begin
  if (edit1.text <> '') then
     begin
          seek (fic, 0);
          trouve := false ;
          while ((not eof(fic)) and (trouve = false)) do
                begin
                     read(fic, joueur);
                     if (joueur.nom = edit1.text) then
                        begin
                             trouve := true;
                             posit :=  filepos(Fic);
                             showmessage('Vous avez chargé votre joueur au nom de : ' + edit1.text);

                             form1.caption := 'Mastermind - joueur : ' + edit1.text;
                             form2.caption := 'Mastermind (décodeur) - joueur : ' + edit1.text;
                             form3.caption := 'Mastermind (codeur) - joueur : ' + edit1.text;
                             form4.caption := 'Mastermind - règles - joueur : ' + edit1.text;
                             form5.caption := 'Mastermind - statistiques - joueur : ' + edit1.text;
                             write(fic, joueur);
                             button1.enabled := True;
                             button2.enabled := True;
                             button4.enabled := True;
                        end;
                end;

          if (trouve = false) then
             begin
                  showmessage('Le nom est incorecte ou n''existe pas ! ');
             end;
     end;
end;



//Bouton quitter l'application
procedure TForm1.Button7Click(Sender: TObject);
begin
  closefile(fic);
  application.terminate ;
end;



procedure TForm1.Edit1Change(Sender: TObject);
begin
  button5.enabled := true;
  button6.enabled := true;
end;


// Autoriser seuelemnt les caractères (A..Z), (a..z) ainsi que les touche backspace pour pouvoir effacer dans l'edit1.text
procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', #8]) then
     begin
            key := #0;          // cela empêche une touche interdite d'être entrée
            showmessage('Attention ! Seul les lettres (A..Z) et (a..z) sont autorisées !');
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  form1.caption := 'Mastermind';
  AssignFile(fic, 'stats.txt');
  reset(fic);
end;

end.

