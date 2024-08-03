function grayImage = mygrayfun(rgbImage)
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    grayChannel = 0.299 * redChannel + 0.578 * greenChannel + 0.114 * blueChannel;
    
    grayImage = grayChannel;
end