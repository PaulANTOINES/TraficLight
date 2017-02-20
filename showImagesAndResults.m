function y = showImagesAndResults(start,stop, directory)
%directory :  ~gepperth/DataIN103/JPG
%Pour chaque image dont le chemin est compris entre start and stop, on va pouvoir parcourir ces images une par une, et afficher leur conversion en Lab
%entr�e : num�ro de la premi�re image : start
         %num�ro de la derni�re image : stop
         %chemin de l'image : directory
%sortie : affichage graphique de l'image normale, puis de l'image filtr�e,
%accompagn�e de rectangles autour des maximas

    j=start
    pasImage = 1 %pasImage entre chaque image lors de la navigation.
    while (j<stop+1) & (j>=start)

        %%Cr�ation de la cha�ne de caract�re correspondant au chemin de
        %%l'image
        
        path = sprintf('%s/frame_%06d.jpg',directory,j);
        path_lab = sprintf('%s/lab_%06d.jpg',directory,j);
        

        %%Affichage de l'image rgb
        %La taille de la matrice repr�sentative RGB (3 dimensions) est : 480x640x3 : pixel horizontal x pixel vertical x 3 valeurs R, G et B
        %Les valeurs vont de 0 � 255 pour les RGB
        
        image = imread(path);
        rgb = imread(path);
        lab = imread(path_lab);
        subplot(1,2,1);
        tt = size(image,1);
        imagesc(image);%affiche l'image
        titre = sprintf('Image de base : %s  pasImage = %d', path, pasImage);
        title(titre,'FontSize',14);
        
      
        %%Conversion de l'image en lab
        
        F = convertColorSpaces(lab);%appel la fonction qui met un filtre � l'image
        subplot(1,2,2);
        imagesc(F);%affiche l'image convertie
        title('Image convertie','FontSize',14);
        hold on;
        
        %% Filtres de d�tections des feux rouges
        % On d�tecte les valeurs maximales dans l'image puis on applique
        % des filtres pour �liminer les points qui ne sont pas des feux
        % rouges.
        
        
        [x,y,maxVals] = detectMaxima(F,1000,5);%appel de la fonction qui d�tecte les maximas, et retourne leurs positions
        threshold = 0.40;%Seuil de d�tection des pixels
        taille = 5; %ecart entre deux points rouge tol�r�
        aire = 64; %Nombre de pixels dans un cercle de rayon 5 pour le filtre Taille.
        thres = 0; %taille du palier pour le filtre Taille
        passed = ones(size(x)); %Pour le i�me pixel d�tect�, passed[i] indique s'il peut s'agir d'un feu rouge (1) ou non (0)
        %passed = passed .* filterDetectionsThreshold(x,y,F,threshold);
        %passed = passed .* filterDetectionsContrainte(x,y,F);%fonction mettant une contrainte sur la position du feu
        %passed = passed .* filterDetectionsSymmetry(x,y,F);
        %passed = passed .* filterDetectionsproximite(x,y,F,taille);%attention � son utilisation : permet de virer les points tr�s rouges trop proches les uns des autres
        passed = passed .* filterDetectionsTaille(x,y,F,aire,thres);%filtre interdisant les trop gros points rouges
        %passed = passed .* filterDetectionsFeuxArrieres(x,y,F); 
        
        %%Affichage de rectangles autour des maximas recherch�s.
        
        for i=1:1:10
            gauche = x(i)-10;
            bas = y(i) - 10;
            w = 20;
            h = 20;
            if gauche<1
                gauche=1;
            end
            if bas<1
               bas = 1;
            end
            if gauche + w >size(F,1)
                w = size(F,1)-gauche;
            end
            if bas + h> size(F,2)
                h = size(F,2) - bas;
            end
            
            if passed(i) == 1          
                rectangle('Position',[bas,gauche,w,h],'EdgeColor','r');
            end
           
            
        end
        
        
        %%Configuration des touches pour naviguer entre les images
        
        buttonpress = waitforbuttonpress;%attend que l'utilisateur appuie sur un bouton pour passer � l'image suivante
        buttonpressed = get(gcf, 'CurrentCharacter'); %Enregistre la touche press�e par l'utilisateur.
        if buttonpressed == 'q'%si on appuie sur q, on recule l'indice des images
            j = j-pasImage
        end
        if buttonpressed == 'd'%si on appuie sur d, on avance dans l'indice des images
            j = j + pasImage
        end
        if buttonpressed == 'a'%si on appuie sur a, on diminue pasImage de 1
            pasImage = pasImage - 1
        end
        if buttonpressed == 'e'%si on appuie sur e, on augmente pasImage de 1
            pasImage = pasImage + 1
        end
        
        hold off;
     
    end
    close%ferme l'image � la fin
end
