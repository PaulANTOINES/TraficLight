function passed = filterDetectionsTaille(x,y,F,Taille, thres)

%Fonction qui va filtrer les maxima dont l�ensemble des pixels rouges directement lies est trop grand pour �tre pris pour un feu.

%Entr�e : matrice des coordonn�es des maximas d�tect�es (x et y), ainsi que la
%matrice des valeurs de chaque pixel de l'image, apr�s traitement par
%lab(F), Taille repr�sente la demi-taille maximale que peux avoir en %pratique pour un feu, d�apr�s la vision que l�on a, et thres permet de %d�finir les pixels consid�r�s comme appartenant � l�ensemble du maxima %d�tect�

%Sortie : passed : matrice de 1 et de 0, 1 correspondant aux maximas ayant pass� le
%filtre, et 0 � ceux ne l'ayant pas pass�

passed = ones(size(x));

%On parcourt tous les maximas, pour v�rifier la taille de leur �ensemble�
for i=1:1:size(x,2)
    compteur_a=1;
    compteur_b=0;
    liste=[[x(i),y(i)]];
    while compteur_a>compteur_b%On parcourt l�ensemble des positions des pixels rouges li�es au maxima �tudi�

        compteur_b = compteur_a;
        for k=compteur_b:1:compteur_a%On parcourt ici la liste des %positions�; et � chaque fois, on en ajoute si la valeur du pixel est %suffisamment haute (>thres)
           
            present = false;
            if liste(k,1)+1 <= size(F,2)
                for l=1:size(liste)
                    if liste(k,1)+1 == liste(l,1)
                        present = true;
                    end
                end
                if present == false & F(liste(k,1),liste(k,2))>thres
                    liste = [liste;[liste(k,1)+1,liste(k,2)]];
                    compteur_a = compteur_a + 1;
                end
            end
            present = false;
            if liste(k,1)-1 > 0
                for l=1:size(liste)
                    if liste(k,1)-1 == liste(l,1)
                        present = true;
                    end
                end
                if present == false & F(liste(k,1)-1,liste(k,2))>thres
                    liste = [liste;[liste(k,1)-1,liste(k,2)]];
                    compteur_a = compteur_a + 1;
                end
            end
            present = false;
            if liste(k,2)+1 <= size(F,1)
                for l=1:size(liste)
                    if liste(k,2)+1 == liste(l,2)
                        present = true;
                    end
                end
                if present == false & F(liste(k,1),liste(k,2))>thres
                    liste = [liste;[liste(k,1),liste(k,2)+1]];
                    compteur_a = compteur_a + 1;
                end
            end
            present = false;
            
            if liste(k,2)-1 >0
                for l=1:size(liste)
                    if liste(k,2)-1 == liste(l,2)
                        present = true;
                    end
                end
                if present == false & F(liste(k,1),liste(k,2)-1)>thres
                    liste = [liste;[liste(k,1),liste(k,2)-1]];
                    compteur_a = compteur_a + 1;
                end
            end
        end
    end
    if size(liste,1) > Taille
        passed(i) = 0;
    end
end
            
        
        

                
    

