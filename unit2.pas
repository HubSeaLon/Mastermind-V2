unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Colorier(C : integer);

  private

  public

  end;

var
  Form2: TForm2;

type typetab1 = array[1..12, 1..6] of integer;    // Tableau qui va gérer le code secret, les comparaisons entre les essais du joueur et le code de l'IA et les calculs de l'IA pour afficher
                                                  // le nombre de couleurs bien placées et le nombre de couleurs justes mais mals placées


var
  tour : integer;
  t1 : typetab1;
  tour_ligne : integer;
  compteur_colonne : integer;
  win, lose : integer;
  juste_bien : integer;
  tot_juste : integer;



implementation

//DECODEUR

uses Unit1;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  form2.hide;
  form1.show;
end;

//Bouton jouer

procedure TForm2.Button2Click(Sender: TObject);
var i, j : integer;


begin
  randomize;
  win := 0;
  lose := 0;
  compteur_colonne := 0; // 0 à 4 pour pouvoir passer au tour suivant. Dès que le compteur passe à 4 : tour -> tour + 1
  tour := 1;   // 1 à 10 pour savoir quand le jeu s'arrêtera
  tour_ligne := 12; // 12 à 2 pour passer à la ligne inférieure quand le tour aura incrémenté

  label1.caption := 'Tour ' + inttostr(tour) + ' : choisissez les couleurs de gauche à droite';

  StringGrid1.canvas.Brush.color := clBlack;   // Remplissage 2eme ligne pour séparer le code de l'IA et les 10 tentatives de l'humain
  for I:=0 to 5 do
    begin
      stringgrid1.canvas.fillrect(Stringgrid1.cellRect(I,1));
    end;

 // Générer le code de l'IA
  for j := 1 to 4 do
    begin
      t1[1,j] := random(6);
    end;
 // Afficher des '?' pour savoir que l'utilisateur doit trouver le code secret
  for j := 0 to 3 do
    begin
      stringgrid1.cells[j,0] := '?';
    end;

 // Autoriser le joueur à utiliser les boutons couleurs pour pouvoir jouer et ne plus autoriser le joueur à relancer la partie tant qu'il n'a pas fini la partie
  button3.enabled := true;
  button4.enabled := true;
  button5.enabled := true;
  button6.enabled := true;
  button7.enabled := true;
  button8.enabled := true;
  button2.enabled := false;


  // réinistialisation du stringgrid
  for j := 0 to 3 do
    begin
      for i := 2 to 11 do
        begin
          stringgrid1.canvas.brush.color := clWhite;
          stringgrid1.canvas.fillrect(stringgrid1.cellRect(j,i));
        end;
    end;

  for j := 4 to 5 do
    begin
      for i := 2 to 11 do
        begin
          stringgrid1.cells[j,i] := '';
        end;
    end;
end;



//Bouton couleur rouge
procedure TForm2.Button3Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 0;
  Colorier(couleur);
end;

//Bouton couleur jaune
procedure TForm2.Button4Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 1;
  Colorier(couleur);
end;

//Bouton couleur verte
procedure TForm2.Button5Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 2;
  Colorier(couleur);
end;

//Bouton couleur bleu
procedure TForm2.Button6Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 3;
  Colorier(couleur);
end;

//Bouton couleur fuchsia
procedure TForm2.Button7Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 4;
  Colorier(couleur);
end;

//Bouton couleur purple
procedure TForm2.Button8Click(Sender: TObject);
var couleur : integer;
begin
  couleur := 5;
  Colorier(couleur);
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  label1.caption := 'Vous êtes décodeur, vous avez 10 essais pour trouver le code de l''IA. Bonne chance !';
end;



// Procedure colorier qui va incrémenter les tours, coloriers les essais du joueur, calculer pour l'IA les 2 colonnes de droite
procedure TForm2.Colorier(C : integer);
var i, j : integer;
    utilise : array[1..4] of boolean;           // Tableau de boolean qui va permettre au calcul de savoir si une couleur a déjà été comparé pour les couleurs justes mais mals placées
begin
  if ((compteur_colonne < 4) and (tour_ligne > 2)) then         // Si la ligne d'essai du joueur n'est pas encore rempli
     begin
          compteur_colonne := compteur_colonne + 1;
          if (c = 0) then
             begin
                t1[tour_ligne,compteur_colonne] := 0;
                stringgrid1.canvas.brush.color := clRed;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;

          if (c = 1) then
             begin
                t1[tour_ligne,compteur_colonne] := 1;
                stringgrid1.canvas.brush.color := clYellow;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;

          if (c = 2) then
             begin
                t1[tour_ligne,compteur_colonne] := 2;
                stringgrid1.canvas.brush.color := clGreen;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;

          if (c = 3) then
             begin
                t1[tour_ligne,compteur_colonne] := 3;
                stringgrid1.canvas.brush.color := clBlue;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;

          if (c = 4) then
             begin
                t1[tour_ligne,compteur_colonne] := 4;
                stringgrid1.canvas.brush.color := clFuchsia;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;

          if (c = 5) then
             begin
                t1[tour_ligne,compteur_colonne] := 5;
                stringgrid1.canvas.brush.color := clPurple;
                stringgrid1.canvas.fillrect(stringgrid1.cellRect(compteur_colonne - 1, tour_ligne - 1));
             end;


          if (compteur_colonne = 4) then        // Si tout est juste et bien placé
             begin
                  tot_juste := 0;
                  juste_bien := 0;
                  for j := 1 to 4 do
                    begin
                      if (t1[1,j] = t1[tour_ligne,j]) then
                         begin
                            juste_bien := juste_bien + 1;
                            if (juste_bien = 4) then
                               begin
                                 win := 1;
                               end;
                         end;
                    end;

                  if (win = 1) then
                         begin
                            showmessage('Gagné ! Vous avez trouvé le bon code en ' + inttostr(tour) + ' tour(s). Félicitations !');
                            label1.caption := 'Pour rejouer cliquez sur "Lancer la partie" ou sinon "Retour au menu"';
                            joueur.tour_gagnant := joueur.tour_gagnant + tour;
                            seek (Fic, posit - 1);
                            write (fic,joueur);
                            joueur.victoire := joueur.victoire + 1 ;
                            seek (Fic, posit - 1);
                            write (fic,joueur);

                            for j := 1 to 4 do
                                        begin
                                             if (t1[1,j] = 0) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clRed;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 1) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clYellow;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 2) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clGreen;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 3) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clBlue;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 4) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clFuchsia;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 5) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clPurple;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                        end;



                            joueur.nombre_partie_total := joueur.nombre_partie_total + 1;               // Incrémentation des stats seulement quand le joueur fini sa partie.
                            seek (Fic, posit - 1);
                            write (fic,joueur);
                            joueur.nombre_partie_decodeur :=  joueur.nombre_partie_decodeur + 1;
                            seek (Fic, posit - 1);
                            write (fic,joueur);



                            button3.enabled := false;         // Ne plus autoriser l'utilisateur à utiliser les boutons. On le force à soit revenir au menu principal ou à relancer une partie.
                            button4.enabled := false;
                            button5.enabled := false;
                            button6.enabled := false;
                            button7.enabled := false;
                            button8.enabled := false;
                            button2.enabled := true;
                         end
                               else


                          // IA qui va compter le nombre de couleur juste et juste bien placé


                         begin
                           juste_bien := 0;
                           tot_juste := 0;

                           // Comptage de couleurs justes biens placées
                           for j := 1 to 4 do
                             begin

                               if (t1[1,j] = t1[tour_ligne,j]) then
                                      begin
                                           juste_bien := juste_bien + 1;
                                      end;
                                stringgrid1.cells[compteur_colonne, tour_ligne - 1] := inttostr(juste_bien);
                             end;


                           // Comptage couleurs justes et mal placé
                           for i := 1 to 4 do
                             begin
                               utilise[i] := false;
                               if (t1[1,i] = t1[tour_ligne,i]) then
                                      begin
                                           t1[tour_ligne,i] := -1;
                                      end
                                                              else
                                      begin
                                        for j := 1 to 4 do
                                          begin
                                            if ((t1[1,i] = t1[tour_ligne,j]) and (not utilise[j]) and (i <> j)) then
                                                   begin
                                                        tot_juste := tot_juste + 1;
                                                        utilise[j] := true;
                                                        break;            // Break permet de sortir de la boucle immédiatement
                                                   end;
                                          end;
                                      end;
                               stringgrid1.cells[compteur_colonne + 1, tour_ligne - 1] := inttostr(tot_juste);
                             end;

                         end;

                  tour_ligne := tour_ligne - 1;
                  tour := tour + 1;
                  compteur_colonne := 0;

                  if (win <> 1) then
                         begin
                            if (tour <= 10) then
                              begin
                                   label1.caption := 'Tour ' + inttostr(tour) + ' : choisissez les couleurs de gauche à droite';
                              end;
                         end;


                  // Si c'est le dernier tour et qu'il ne trouve toujours pas

                  if (tour_ligne = 2) then
                     begin
                          if (win = 0) then
                                 begin
                                    showmessage('Perdu ! Vous n''avez pas trouvé le bon code en 10 coups. Retentez votre chance ou revoyez votre stratégie. Le code de l''IA s''affiche ! ');
                                    label1.caption := 'Pour retentez votre chance cliquez sur "Lancer la partie" ou sinon "Retour au menu"';

                                    //Affichage couleur
                                    for j := 1 to 4 do
                                        begin
                                             if (t1[1,j] = 0) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clRed;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 1) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clYellow;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 2) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clGreen;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 3) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clBlue;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 4) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clFuchsia;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                             if (t1[1,j] = 5) then
                                                begin
                                                     stringgrid1.canvas.brush.color := clPurple;
                                                     stringgrid1.canvas.fillrect(stringgrid1.cellRect(j-1,0));
                                                end;
                                        end;


                                    joueur.nombre_partie_total := joueur.nombre_partie_total + 1;
                                    seek (Fic, posit - 1);
                                    write (fic,joueur);
                                    joueur.nombre_partie_decodeur :=  joueur.nombre_partie_decodeur + 1;
                                    seek (Fic, posit - 1);
                                    write (fic,joueur);


                                    button3.enabled := false;
                                    button4.enabled := false;
                                    button5.enabled := false;
                                    button6.enabled := false;
                                    button7.enabled := false;
                                    button8.enabled := false;
                                    button2.enabled := true;
                                    joueur.defaite := joueur.defaite + 1;
                                    seek (Fic, posit - 1);
                                    write (fic,joueur);
                                 end;
                     end;
             end;
     end;
end;
end.

