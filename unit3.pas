unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  MaskEdit;                              // CODEUR

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure colorer(S:string;
                      T,C:integer);
    procedure FormActivate(Sender: TObject);
    procedure ttcolorer (C1, C2, C3, C4:string;
                      L:integer);
  private

  public

  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.lfm}

{ TForm3 }

var tour:integer;
    comp: array[0..1295] of string;
    tour1 : integer;









procedure TForm3.colorer(S:string;
                  T,C:integer);
     begin
       if ( S = '0' ) then
         Begin
           StringGrid1.canvas.Brush.color := clRed;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
       if ( S = '1' ) then
         Begin
           StringGrid1.canvas.Brush.color := clYellow;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
       if ( S = '2' ) then
         Begin
           StringGrid1.canvas.Brush.color := clGreen;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
       if ( S = '3' ) then
         Begin
           StringGrid1.canvas.Brush.color := clBlue;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
       if ( S = '4' ) then
         Begin
           StringGrid1.canvas.Brush.color := clFuchsia;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
       if ( S = '5' ) then
         Begin
           StringGrid1.canvas.Brush.color := clPurple;
           stringgrid1.canvas.fillrect(Stringgrid1.cellRect(C,T));
         end;
     end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  randomize;
end;

procedure TForm3.ttcolorer (C1, C2, C3, C4  :string;
                  L:integer);
   var C:integer;
     Begin
       C:=0;
       colorer(C1,L,C);
       C:=C+1;
       colorer(C2,L,C);
       C:=C+1;
       colorer(C3,L,C);
       C:=C+1;
       colorer(C4,L,C);
     end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  form3.hide;
  form1.show;
end;

procedure TForm3.Button2Click(Sender: TObject);
var I,j,k,l,a,i1,i2:integer;
   St1,St2,St3,St0:string;
begin

  edit2.text := '';
  edit3.text := '';



  tour1:= 1;
  StringGrid1.canvas.Brush.color := clWhite;
  for i1:=0 to 5 do
    begin
      for i2:=0 to 11 do
        begin
          stringgrid1.canvas.fillrect(Stringgrid1.cellRect(i1,i2));
        end;
    end;
  StringGrid1.canvas.Brush.color := clBlack;
  for I:=0 to 5 do
    begin
      stringgrid1.canvas.fillrect(Stringgrid1.cellRect(I,10));
    end;
  tour:=11;
  St0:=edit4.text[1];
  St1:=edit4.text[2];
  St2:=edit4.text[3];
  St3:=edit4.text[4];
  ttcolorer(St0,St1,St2,St3,tour);
  edit1.text:= inttostr(random(6))+inttostr(random(6))+inttostr(random(6))+inttostr(random(6));
  tour:=0;
  St0:=edit1.text[1];
  St1:=edit1.text[2];
  St2:=edit1.text[3];
  St3:=edit1.text[4];
  ttcolorer(St0,St1,St2,St3,tour);
  button4.enabled:=true;
  button2.enabled:=false;
  button3.enabled:=false;
  a:=0;
  for I:=0 to 5 do
    Begin
      for J:=0 to 5 do
        Begin
          for K:=0 to 5 do
            Begin                                             //Génération de tous les codes possibles
              for L:=0 to 5 do
                Begin
                  comp[a]:=IntToStr(i) + IntToStr(j) + IntToStr(k) + IntToStr(l);
                  a:=a+1;
                end;
            end;
        end;
    end;
end;






procedure TForm3.Button3Click(Sender: TObject);           // vérification du code secret de l'utilisateur
var I:integer;
    S:string;
    bon:boolean;
begin
  if (length(edit4.text)<>4) then
    begin
      label2.caption:='Code incomplet, votre code doit obligatoirement comporte 4 chiffres.';
    end
                               else
      begin
        bon:=true;
              for I:=1 to 4 do
                begin
                  S:=edit4.text[I];;
                  if (S='6') or (S='7') or (S='8') or(S='9') then
                    begin
                      bon:=false;
                    end;
                end;
                if (bon=false) then
                  begin
                    label2.caption:='Veuillez rentrer un code correct pour démarrer la partie.';
                    label3.caption:='Pour rappel, votre code doit comporter 4 chiffres situés entre 0 et 5.';
                  end;
                if (bon=true) then
                  begin
                    label2.caption:='Code correcte, vous pouvez maintnant commencer votre partie';
                    label3.caption:='Pour commencer votre partie, veuillez cliquer sur le bouton ci-dessous.';
                    edit4.enabled:=false;
                    button2.enabled:= true;
                  end;
      end;
end;







procedure TForm3.Button4Click(Sender: TObject);
var a,b,c,d,i,j,k,l,r,som,i1,i2:integer;
    v,imp,p,q:boolean;
    c1,c2,c3,c4,str1,str2:string;
begin
    q := false;
    for i2 := 0 to 1295 do
      begin
        if (comp[i2] <> '') then
          begin
            q := True;
            break;
          end;
      end;

    if (q = false) then
      begin
        showmessage('Partie terminée, vous avez donné de fausses informations ! Veuillez à bien compter le nombre de couleurs justes et couleurs justes mais mals placées. Pour relancer la partie, rentrez un nouveeau code et vérifiez le.');
        edit4.text:='';
        edit4.enabled:=true;
        button4.enabled:=false;
        button3.enabled:=true;
      end
                   else
      begin




    if (tour < 9) then
      begin
        if (edit2.text<>'') and (edit3.text<>'') then
          begin
            if (strtoint(edit2.text)=4) and (strtoint(edit3.text)=0) then      //PARTIE gagné par l'IA
              begin
                if (edit1.text=edit4.text) then
                  begin

                    showmessage('L''IA a trouvé votre code secret. Pour recommencer une partie, rentrez à nouveau un code secret');
                    stringgrid1.cells[4,tour]:=edit2.text;
                    stringgrid1.cells[5,tour]:=edit3.text;
                    joueur.victoire_ia := joueur.victoire_ia + 1;
                    seek (Fic, posit - 1);
                    write (fic,joueur);
                    joueur.tour_gagnant_ia :=joueur.tour_gagnant_ia + tour1;
                    seek (Fic, posit - 1);
                    write (fic,joueur);
                    edit4.text:='';
                    edit4.enabled:=true;
                    button4.enabled:=false;
                    button3.enabled:=true;

                     joueur.nombre_partie_total := joueur.nombre_partie_total + 1;        // Incrémentation stats
                     seek (Fic, posit - 1);
                     write (fic,joueur);
                     joueur.nombre_partie_codeur :=  joueur.nombre_partie_codeur + 1;
                     seek (Fic, posit - 1);
                     write (fic,joueur);
                     joueur.nombre_partie_decodeur_ia :=  joueur.nombre_partie_decodeur_ia + 1;
                     seek (Fic, posit - 1);
                     write (fic,joueur);
                  end
                                               else
                    begin
                      showmessage('Pas de correspondance, veuillez rentrer des valeurs corrects');
                    end
              end
                                                                     else
                begin
                  som:=strtoint(edit2.text) + strtoint(edit3.text);
                  imp:=false;
                  if (strtoint(edit2.text)=3) and (strtoint(edit3.text)=1) then
                    begin
                      imp:=true;
                    end;
                  if (strtoint(edit2.text)<4) and (strtoint(edit3.text)<5) and (som<5) and (imp=false) and (length(edit2.text) = 1) and (length(edit3.text) = 1)  then
                    begin
                      tour1 := tour1 + 1;
                      label6.caption:='';
                      stringgrid1.cells[4,tour]:=edit2.text;
                      stringgrid1.cells[5,tour]:=edit3.text;
                      tour:=tour+1;
                      a:=strtoint(edit2.text);
                      b:=strtoint(edit3.text);
                          for I := 0 to 1295 do
                            begin
                              if (comp[i] <> '') then
                                begin
                                  c := 0;
                                  d := 0;
                                  str1:=edit1.text;
                                  str2:=comp[i];
                                  for k:=1 to 4 do
                                    begin
                                      l:=pos(str1[k], str2);
                                      if (l > 0) then
                                        begin
                                          d:=d+1;                  //On compte ici le nombre de chiffres corrects peu importe si bien ou mal placé
                                          delete (str2,l,1);       //On supprime le caractère "l" de la chaine de caractère "str2" pour éviter des compter les doublons
                                        end;
                                    end;
                                  for j := 1 to 4 do
                                  begin
                                    if (comp[i][j] = edit1.text[j]) then
                                    begin
                                      c := c + 1;                   //  On comptre ici le nombre de chiffres corrects bien placés
                                    end;
                                  end;

                                  d:=d-c;               // On soustrait ces valeurs pour obtenir le nombre de chiffres corrects mal placés

                                  if (a <> c) or (b <> d) then
                                    begin
                                      comp[i] := '';                             // On élimine un code possible si il ne correspond pas aux critèress attendus
                                    end;
                                end;

                            end;



                      p := false;
                      for i1 := 0 to 1295 do
                          begin
                            if (comp[i1] <> '') then
                              begin
                                p := true;
                                break;
                              end;
                          end;

                      if (p = true) then
                        begin

                      v:=false;

                      while (v = false) do
                        begin
                          r:= random(1296);
                          if (comp[r] <> '' ) then                //Regénération d'une réponse pour l'IA
                            begin
                              edit1.Text:=comp[r];
                              v:=true;
                            end;
                        end;


                          c1:=edit1.text[1];
                          c2:=edit1.text[2];
                          c3:=edit1.text[3];
                          c4:=edit1.text[4];
                          ttcolorer(c1,c2,c3,c4,tour);
                          edit2.text:='';
                          edit3.text:='';
                        end
                    end
                                                                           else
                      begin
                        label6.caption:='Erreur! Veuillez entrer des valeurs correctes.';
                      end;
                end;
          end
                                                 else
            begin
              label6.caption:='Erreur! Veuillez entrer des valeurs dans les 2 cases.';
            end;
      end
                  else
        begin                                     //PARTIE PERDUE quand nombre de tours limites dépassés
          showmessage('Gagné! L''IA n''a pas trouvé votre code secret. Pour recommencer une partie, rentrez à nouveau un code secret');
          edit4.text:='';
          edit4.enabled:=true;
          button4.enabled:=false;
          button3.enabled:=true;


           joueur.nombre_partie_total := joueur.nombre_partie_total + 1;        // Incrémentation stats
           seek (Fic, posit - 1);
           write (fic,joueur);
           joueur.nombre_partie_codeur :=  joueur.nombre_partie_codeur + 1;
           seek (Fic, posit - 1);
           write (fic,joueur);
           joueur.nombre_partie_decodeur_ia :=  joueur.nombre_partie_decodeur_ia + 1;
           seek (Fic, posit - 1);
           write (fic,joueur);

          joueur.defaite_ia := joueur.defaite_ia + 1;
          seek (Fic, posit - 1);
          write (fic,joueur);
        end;
  end;
end;


end.

