function passed = filterDetectionsThreshold(x,y,F,threshold)

%Fontion qui va filtrer les valeurs des maximas détectés en supprimant ceux
%dont la valeur dépasse celle du seuil imposé.

%Entrée : matrice des coordonnées des maximas détectées (x et y), ainsi que la
%matrice des valeurs de chaque pixel de l'image, après traitement par
%lab(F), et la valeur seuil qui sera utilisée comme filtre : threshold.

%Sortie : passed : matrice de 1 et de 0, 1 correspondant aux maximas ayant passé le
%filtre, et 0 à ceux ne l'ayant pas passé

%Informations :

%Ici, on a prit une valeur seuil de 0.38, qui a été choisis après avoir
%fait défiler un grand nombre d'images pour voir l'échelle des valeurs de
%rouge qu'un feux pouvait renvoyer



%Création de la matrice de sortie, uniquement constituée de 0, les 1 seront
%rajoutés pour les maximas qui passent le filtre.
    passed = zeros(size(x));
    
%On parcours l'ensemble des maximas, et on compare à chaque fois à la
%valeur seuil : threshold.


for i=1:1:size(x,2)
        if F(x(i),y(i))>threshold
            passed(i) = 1;
        end
    end
end
