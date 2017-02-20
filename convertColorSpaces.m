function imageRedGreen = convertColorSpaces(lab)

    %Fonction qui convertit une image en lab en image Lab, où les différences entre vert et rouge sont encore plus accentués

    %entrée : matrice de l’image en lab

    %sortie : matrice de l’image en lab améliorée
  
    %Le traitement effectué est de ramener les valeurs de a et b à des valeurs comprises entre -1 et 1, et pour L, à des valeurs entre 0 et 1.

    lab_new(:,:,1) = double(lab(:,:,1))./255;
    lab_new(:,:,2) = ((double(lab(:,:,2)))-128)./128;
    lab_new(:,:,3) = ((double(lab(:,:,3)))-128)./128;
    
    %Ensuite, on va assigner à chaque pixel la valeur Lxa + b, comprise entre -2 et 2, afin d’accélérer le filtrage car il n’y a qu’une seule composante à prendre en compte, et de renforcer les différences entre rouge et vert, pour éviter les erreurs.

    F = lab_new(:,:,1).*(lab_new(:,:,2)+lab_new(:,:,3));
    imageRedGreen = F;
end








