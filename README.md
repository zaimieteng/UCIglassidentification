# Glass Identification — k-NN Classifier

k-Nearest Neighbours classification model to predict the type of glass
found at a crime scene based on its physical and chemical composition.

## Problem Statement
Identifying glass type from crime scenes requires analysing chemical
composition. This project applies k-NN to classify glass samples into
7 categories (building windows, vehicle windows, containers, tableware,
headlamps) using 9 chemical and physical features.

## Key Findings
- Initial model achieved 65.11% accuracy — lower than the breast cancer
  project due to the multi-class nature of the problem (7 classes vs 2)
- Iterating k from 1 to 20 with min-max normalisation found k=4
  as the best, achieving 69.76% accuracy
- Z-score standardisation alone performed worse at 62.79%
- Combining z-score standardisation with k optimisation (k=11)
  significantly improved accuracy to 78%

## Model Results

| Method | Best k | Accuracy |
|---|---|---|
| Min-max normalisation | 4 | 69.76% |
| Z-score standardisation | 11 | 78.00% |
| Initial (no standardisation) | 14 | 65.11% |

## Tools Used
R — class package (k-NN), caret

## Data Source
UCI Machine Learning Repository — Glass Identification
[Dataset link](https://archive.ics.uci.edu/dataset/42/glass+identification)
