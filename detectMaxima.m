function  [x,y,maxVals] = detectMaxima(F, nrMaxima, boxSize)

%Fonction qui indique les valeurs des maximas d'une image, ainsi que leur %position sur l’image : x, pixel vertical et y pixel horizontal.

%entrées : F : valeurs lab améliorées des pixels de l'image convertie
%          nrMaxima : nombre de maximum que l'on souhaite rechercher
          %boxSize : Taille de la boîte autour de chaque maxima, où l’on %ne cherche pas de maximum, pour ne détecter qu’un seul maxima par feux.

%sortie : vecteurs des positions (x,y) des maximas, et valeurs des maximums détectés.

%Informations :

%Ici, on a prit une valeur de boxSize de 5, ce qui nous sembles pertinent %ici, afin de continuer à détecter les feux rouges, même à distance.
%De plus, nous avons choisis comme valeur de nrMaxima, 1000, afin de %continuer à détecter les feux rouges, même si une grosse trace de rouge %traverse l’écran (ex : une ambulance, un véhicule de pompiers…).

    n = nrMaxima;
    x = zeros(1,nrMaxima);
    y = zeros(1,nrMaxima);
    maxVals = zeros(1,nrMaxima);

    while nrMaxima>0 %tant que l'on a encore des maximas à chercher
        [T,X] = max(F);
        [T,Y] = max(T); %colonne du maximum
        X = X(Y); %ligne du maximum
        x(n-nrMaxima+1) = X; %correspond au pixel vertical 
        y(n-nrMaxima+1) = Y; %correspond au pixel horizontal

        maxVals(n-nrMaxima+1) = T;%valeur du maximum

        gauche = X - boxSize;%positions de l'ensemble des pixels à neutraliser
        droite = X + boxSize;
        haut = Y - boxSize;
        bas = Y + boxSize;
        
        
        if X-boxSize<1
            gauche = 1;
        end
        if X+boxSize>size(F,1)
            droite = size(F,1);
        end
        if Y-boxSize<1
            haut = 1;
        end
        if Y+boxSize>size(F,2)
            bas = size(F,2);
        end
        
       
        F(gauche:droite,haut:bas) = 0;%Neutralisation des pixels autour %du maxima détecté
        nrMaxima = nrMaxima - 1 ;
        
    end 
    
                 
    

end

  




