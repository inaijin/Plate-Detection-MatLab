function outputImage = myremovecom(binaryImage, n)
    labeledImage = mysegmentation(binaryImage);
    
    stats = regionprops(binaryImage, 'Area');
    
    for i = 1:length(stats)
        if stats(i).Area < n
            labeledImage(labeledImage == i) = 0;
        end
    end
    
    outputImage = labeledImage > 0;
end