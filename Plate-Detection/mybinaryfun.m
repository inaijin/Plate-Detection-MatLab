function binaryImage = mybinaryfun(grayImage)
    binaryImage = grayImage > 100;
    
    binaryImage = double(binaryImage);
end