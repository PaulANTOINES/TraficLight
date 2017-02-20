function passed = filterDetectionsContrainte(x,y,F)
%Fonction qui retourne lesquels des maximas d�tect�s sont dans la partie
%sup�rieure de l'image (l� o� se trouvent habituellement les feux rouges).
%Entr�es : x,y : coordonn�es des maximas
%          F : l'image
%Sortie : passed un vecteur de taille le nombre de maxima. Pour chaque
%         maxima, la valeur correspondante vaut 1 s'il est valide selon le
%         filtre et 0 sinon
%La ligne de d�marcation est un ligne au 3/10 de l'image avec un triangle
%de taille 1/10 et de largeur 2/10 au milieu.

    passed = zeros(size(x));
        for i=1:1:size(x,2)
            if x(i) < (3/10)*size(F,1)  %Elimine les points au dessous de 3/10 de l'image en partant du haut.
                passed(i) = 1;
            end
            if y(i)>-x(i)+(7/10)*size(F,1) & y(i)<(1/2)*size(F,2) %Elimine les points au dessous de la ligne correspondant au c�t� gauche du triangle
                passed(i) = 0;
            end
            if y(i)<x(i)+(1/10)*size(F,1) & y(i)>(1/2)*size(F,2) %Elimine les points au dessous de la ligne correspondant au c�t� droit du triangle
                passed(i) = 0;    
            end
        end
        
end
