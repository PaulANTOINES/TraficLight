function passed = filterDetectionsFeuxArrieres(x,y,F)

%Fonction qui va filtrer les objets qui ont une symétrie axiale par rapport %à l’axe des x (vertical), comme les feux de voiture, qui malgré le filtre %threshold peuvent être détectés si l’on est à une certaine distance du %feu.
    
%Entrée : matrice des coordonnées des maximas détectées (x et y), ainsi que la
%matrice des valeurs de chaque pixel de l'image, après traitement par
%lab(F).

%Sortie : passed : matrice de 1 et de 0, 1 correspondant aux maximas ayant passé le
%filtre, et 0 à ceux ne l'ayant pas passé


    passed = zeros(size(x));

    for j= 1:size(x,2)
        for k= 1:size(x,2)%pour chaque maxima, on parcourt l’ensemble des maximas, pour voir les possibles symétries
            if k ~=j & not(abs(x(j)-x(k))<5 & abs(y(j)-y(k))>50 & abs(y(j)-y(k))<300) %si deux maximas sont %suffisamment proches en x (verticale), et pas trop loin en y (horizontale : >50 pour éviter que deux %maximas sur un feu soient pris pour symétriques, et ainsi pas pris en compte ; <300 pour éviter de %supprimer des feux dans le cadre de feux symétriques de part et d’autre de la route.

                  passed(j) = 1;
              
            end
        end
    end
end
