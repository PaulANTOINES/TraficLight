function passed = filterDetectionsproximite(x,y,F,taille)
    %Fonction de proximité qui interdit la présence de maximas trop proches les un des autres.
    
    %Entrée : matrice des coordonnées des maximas détectées (x et y), ainsi que la
    %matrice des valeurs de chaque pixel de l'image, après traitement par
    %lab  (F), et la valeur seuil qui sera utilisée pour régler la proximité maximale toléré entre 2 maximas. (taille)

    %Sortie : passed : matrice de 1 et de 0, 1 correspondant aux maximas       ayant passé le
    %filtre, et 0 à ceux ne l'ayant pas passé

    %Informations :

    %Ici, nous avons choisis pour la valeur de la taille, la valeur de %10, afin d’éviter que le filtre soit trop efficace et qu’il supprime %trop de valeurs.

    passed = ones(size(x));
    size(x)
    % On parcourt l’ensemble des maximas détectés, et pour chacun, on regarde sa proximité avec les autres maximas.

    for i=1:1:size(x,2)
        for j=1:1:size(x,2)
            X = x(i)-x(j);
            if x(i)-x(j)<0
                X = x(j)-x(i);
            end
            Y = y(i)-y(j);
            if y(i)-y(j)<0
                Y = y(j)-y(i);
            end
            if i~=j & X<taille & Y<taille 

%Si cette proximité est en dessous de la valeur minimale tolérée, elle est filtrée.

                passed(i) = 0;
                passed(j) = 0;
                
            end
        end
    end
end

