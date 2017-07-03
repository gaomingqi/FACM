# FACM
## Introduction
This project is a MATLAB implementation for the texture segmentation method in paper:   
"A Factorization based Active Contour Model for Texture Segmentation", Mingqi Gao, Hengxin Chen, Shenhai Zheng, Bin Fang, IEEE International Conference on Image Processing (ICIP 2016).
## Statement
-- In this project, the extraction of texture features from input image is based on the original code provided by Jiangye Yuan, Deliang Wang et al:  
[1] Yuan J, Wang D, Cheriyadat A M. Factorization-Based Texture Segmentation.[J]. IEEE Transactions on Image Processing, 2015, 24(11):3488-97.   
-- The penalty term of level set function is implemented based on Chunming Li's paper:  
[2] Li C, Xu C, Gui C, et al. Level Set Evolution without Re-Initialization: A New Variational Formulation.[C]. IEEE Conference on Computer Vision and Pattern Recognition, 2005. 430-436.
## Usage
Test texture images are located in "images" folder.  
Run "main_FACM.m" to get segmentation results.
