function passed = filterDetectionsSymmetry(x,y,F)
%Fonction qui retourne lesquels des maximas respectent la symétrie
%sphérique d'un feu rouge
%Entrées : x,y : coordonnées des maximas
%          F : l'image
%Sortie : passed un vecteur de taille le nombre de maxima. Pour chaque
%         maxima, la valeur correspondante vaut 1 s'il est valide selon le
%         filtre et 0 sinon
%Pour vérifier qu'une image est symétrique on fait son produit scalaire
%avec sa transposée en utilisant la fonction filter2. Pour éviter les
%problèmes dans le cas où le maximum se trouverait au bord du feu et non au
%centre, on utilise la fonction filter2 qui calcule le produit scalaire en
%décalant l'une des images selon plusieurs valeurs.

passed = zeros(size(x));
for i=1:1:size(x,2)
    
    if (y(i)-4>0) & (y(i)+4<size(F,2)) & (x(i)-4>0) & (x(i)+4<size(F,1)) 
        
        box_=F(x(i)-4:x(i)+4,y(i)-4:y(i)+4); %Définition de la sous matrice autour du maximum dont on veut tester la symétrie. 
        
        BOX = filter2(box_,box_'); %BOX est une matrice qui contient les valeurs du produit scalaire selon plusieurs décalages.
        
        diff = BOX./(norm(box_)*norm(box_')); %On normalise BOX
        a = max(max(diff)); %On recherche la valeur maximale dans BOX
        
        
        if a>0.8 %Seuil du produit scalaire à partir duquel on considère que le maximum présente une symétrie.
            passed(i) = 1;
            
        end
    end
    
    
    
end
end
        
