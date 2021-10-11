# Machine Learning analysis of the human infant gut microbiome identifies influential species in type 1 diabetes
# DOI: https://doi.org/10.1016/j.eswa.2021.115648

![alt text](https://github.com/DiegoFE94/MLMetaGenomics/blob/master/GraphicalAbstract.png)


# Data
The data used in this work was downloaded from the [DIABIMMNUE](https://diabimmune.broadinstitute.org/diabimmune) project. This project, financed by the European Union through the H2020 initiative in 2016, was set up with the aim of testing the hygiene hypothesis and its role in the development of T1D. For this study, the T1D cohort was used, which aims to compare the microbiome of infants who have developed T1D with healthy controls from the same geographical area. Fecal samples were extracted from each individual and ribosomal 16S RNA sequencing was performed to characterize the metagenomic profile. For this study, data on the relative abundance of each operative taxonomic unit (OTU) of the different infants that make up the cohort were downloaded. The samples have been labelled according to patients and T1D controls. In total, 124 samples have been included for analysis, from a total of 33 infants.

# Abstract
In recent years and due to the large number of recent studies, it is known that changes in the balance of the microbiota can cause a high battery of diseases, including diabetes. Machine Learning (ML) techniques are able to identify expression patterns and complex, non-linear relationships between the data set to extract intrinsic knowledge without any biological assumptions about the data. At the same time, the techniques of mass sequencing allow us to obtain the metagenomic profile of an individual, whether it is a body part, organ or tissue, thus being able to identify the composition of a particular microbe. The great increase in the development of both technologies in their respective fields of study leads to the logical union of both to try to identify the basis of a complex disease such as diabetes. In this repository is stored the pipeline used to carry out a study to use machine learning as a diagnostic method of type 1 diabetes.


## Prerequisites:

The packages we've used:

```{r}
install.packages(c("ggplot2", "mlr", "dplyr", "parallelMap", "stringr", "caret"))
```


# Visualization results
Also, you can access to all results of the project through the [Shiny](https://diegofedreira.shinyapps.io/shinyapp/) web developed.

If you are interested on shiny aplications, the code of this project is available on [Github](https://github.com/DiegoFE94/ShinyMLMetagenomics).

## Questions?
If you have any questions, please feel free to contact (diego.fedreira@udc.es).
