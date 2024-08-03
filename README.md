# License Plate Detection in MATLAB

## Introduction
This project aims to detect both English and Iranian license plates using MATLAB. The project comprises two parts: utilizing MATLAB's existing tools and implementing the detection process from scratch. The steps include resizing the image, converting it to grayscale, noise removal, segmentation, and final detection using an existing dataset.

[Project Overview](#project-overview)
   - [MATLAB Tools Based Detection](#matlab-tools-based-detection)
   - [Custom Implementation Detection](#custom-implementation-detection)

## Project Overview

### MATLAB Tools Based Detection
1. **Resizing the Plate:**
   - The license plate image is resized to a standard dimension to ensure uniform processing.

2. **Grayscale Conversion:**
   - The resized image is converted to grayscale to simplify the subsequent processing steps.

3. **Noise Removal:**
   - Noise is removed using MATLAB's built-in functions to ensure the image is clean for segmentation.

4. **Segmentation:**
   - The image is segmented based on the white parts, isolating the characters of the license plate.

5. **Detection:**
   - The segmented characters are compared against an existing dataset of English and Persian plate numbers to identify the license plate.

### Custom Implementation Detection
1. **Grayscale Conversion:**
   - A custom threshold is applied where pixel values below the threshold are set to black and those above it to white.

2. **Noise Removal:**
   - Connected components are analyzed, and those below a heuristically determined threshold are removed.

3. **Segmentation:**
   - The image is traversed row by row, identifying the regions with the most significant difference between black and white pixels, which likely correspond to the license plate characters.

4. **Detection:**
   - The segmented regions are analyzed and matched against a custom dataset to identify the license plate.


By following the structured steps and utilizing MATLAB's powerful tools, this project achieves efficient detection of both English and Iranian license plates. The custom implementation further demonstrates the fundamental image processing techniques, ensuring a comprehensive understanding of the license plate detection process.


## Contributing
We welcome contributions to enhance the project.
