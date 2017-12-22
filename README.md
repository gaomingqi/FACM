# FACM
A MATLAB implementation for the texture segmentation method in paper:   
>[A factorization based active contour model for texture segmentation](http://ieeexplore.ieee.org/document/7533173/), Mingqi Gao, Hengxin Chen, Shenhai Zheng, Bin Fang, IEEE International Conference on Image Processing (ICIP 2016).    

To use FACM as academic purpose, please cite this paper. Some details about it can be found in [my blog](https://gaomingqi.github.io/posts/2017/04/blog-post-3/).

## Statement
1. In this project, the extraction of texture features from given image is based on the theory proposed by Jiangye Yuan, Deliang Wang et al:  
[Factorization-Based Texture Segmentation](http://ieeexplore.ieee.org/document/7127013/). Jiangye Yuan, Deliang Wang, and Anil M Cheriyadat. IEEE Transactions on Image Processing, 2015.   
2. The penalty term of energy functional is implemented based on Chunming Li's paper:  
[Level Set Evolution without Re-Initialization: A New Variational Formulation](http://ieeexplore.ieee.org/document/1467299/). Chunming Li, Chenyang Xu, Changfeng Gui, and Martin D. Fox. IEEE CVPR, 2005.

## Usage
* The test images are placed in "images" folder;
* You can load the existing initial contours from "initial contours" folder or select a polygonal region by hand;
* Also, you can record the evolution process of active contours in a GIF file;
* Segmentation results will be saved in "results" folder;
* __Run "main_FACM.m" directly to get segmentation results!__