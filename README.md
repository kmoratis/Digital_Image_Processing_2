# Digital_Image_Processing
Assignment on Digital Image Processing University course

## Contents:

### Raw to RGB image transformation

 - Reading Raw image (.DNG) and extracting useful metadata

 - White-balancing, adjusted to Bayer pattern ( 'RGGB', 'BGGR', 'GRBG', 'GBRG' )

 - Nearest-neighbor interpolation - bilinear interpolation

 - Space transforms ( Cam, XYZ, sRGB )

### Optical Character Recognition

- Find image rotation angle of a text image, using its DFT and horizontal projection

- Image rotation implementation and white-padding

- Find the contours of a character contained in an image

- Create training dataset from given image

- Training - validation set split

- Train K-NN classification models

- Evaluate models using given test image

### Image Registration 

- Harris corner detector

- Local rotation-invariant  pixel descriptor

- Descriptor matching

- RANSAC algorithm implementation

- Image Stitching


## Getting started 

### Prerequisites

Make sure you have MATLAB installed on your system. This project was developed and tested using MATLAB R2019a.

### Installation

1. **Download:** Click on the "Clone or download" button on this repository and choose "Download ZIP." Alternatively, you can use Git to clone the repository.

2. **Extract:** After downloading, extract the contents of the ZIP file to a location of your choice.

### Running Demos

The project is organized into different sections, each addressing specific image processing tasks. To see the results, follow these steps:

#### Raw to RGB Image Transformation

1. Navigate to the "Raw to RGB image transformation" folder.

2. Run the demo scripts provided for each function

3. Explore the results displayed in the MATLAB figures.

#### Optical Character Recognition

1. Go to the "Optical Character Recognition" folder.

2. Run the demo scripts for each OCR function

3. Examine the output and visualizations in the MATLAB figures.

#### Image Registration

1. Open the "Image Registration" folder.

2. Execute the demo scripts for different tasks

3. Review the stitched images and other relevant visualizations.