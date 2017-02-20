function passed = filterDetectionsSymmetry(x,y,F)
%Fonction qui retourne lesquels des maximas respectent la sym�trie
%sph�rique d'un feu rouge
%Entr�es : x,y : coordonn�es des maximas
%          F : l'image
%Sortie : passed un vecteur de taille le nombre de maxima. Pour chaque
%         maxima, la valeur correspondante vaut 1 s'il est valide selon le
%         filtre et 0 sinon
%Pour v�rifier qu'une image est sym�trique on fait son produit scalaire
%avec sa transpos�e en utilisant la fonction filter2. Pour �viter les
%probl�mes dans le cas o� le maximum se trouverait au bord du feu et non au
%centre, on utilise la fonction filter2 qui calcule le produit scalaire en
%d�calant l'une des images selon plusieurs valeurs.

passed = zeros(size(x));
for i=1:1:size(x,2)
    
    if (y(i)-4>0) & (y(i)+4<size(F,2)) & (x(i)-4>0) & (x(i)+4<size(F,1)) 
        
        box_=F(x(i)-4:x(i)+4,y(i)-4:y(i)+4); %D�finition de la sous matrice autour du maximum dont on veut tester la sym�trie. 
        
        BOX = filter2(box_,box_'); %BOX est une matrice qui contient les valeurs du produit scalaire selon plusieurs d�calages.
        
        diff = BOX./(norm(box_)*norm(box_')); %On normalise BOX
        a = max(max(diff)); %On recherche la valeur maximale dans BOX
        
        
        if a>0.8 %Seuil du produit scalaire � partir duquel on consid�re que le maximum pr�sente une sym�trie.
            passed(i) = 1;
            
        end
    end
    
    
    
end
end
        
