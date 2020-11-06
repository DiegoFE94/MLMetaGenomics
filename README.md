# MachineLearningMetagenomics
## Data Availability 

Data were taken from the Diabinmune project (https://diabimmune.broadinstitute.org/diabimmune/t1d-cohort), which consists of a public database of faecal metagenomic profiles from sequencing of the 16S rRNA region. The dataset includes 124 faecal samples with the metagenomic profile of newborn children.

## Abstract

In recent years and due to the large number of recent studies, it is known that changes in the balance of the microbiota can cause a high battery of diseases, including diabetes. Machine Learning (ML) techniques are able to identify expression patterns and complex, non-linear relationships between the data set to extract intrinsic knowledge without any biological assumptions about the data. At the same time, the techniques of mass sequencing allow us to obtain the metagenomic profile of an individual, whether it is a body part, organ or tissue, thus being able to identify the composition of a particular microbe. The great increase in the development of both technologies in their respective fields of study leads to the logical union of both to try to identify the basis of a complex disease such as diabetes.

### Prerequisites:

The packages we've used:

```{r}
install.packages(c("ggplot2", "mlr", "dplyr", "parallelMap", "stringr", "caret"))
