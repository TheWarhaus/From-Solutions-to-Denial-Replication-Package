# Replication Package

## Parliamentary Turbulence: Drivers of Climate Policy Opposition in MEPs’ Legislative Behaviour

This repository contains code and data required to replicate the analyses in the accompanying manuscript.

## Files

### Code
- **analysis.do**  
  Stata code used to estimate all regression models, marginal effects, robustness checks, and regression figures reported in the paper.

- **annotation_evaluation.ipynb**  
  Python/Jupyter notebook used to compute summary statistics, evaluate text classification performance, and generate confusion matrices.

## Data
- **speech_data.dta**  
  Dataset used for speech framing and voting behavior analyses.

- **vote_data.dta**  
  Dataset used for voting behavior analyses.

- **evaluation_df.csv**  
- **evaluation_df_detailed.csv**  
  Datasets used for text classification evaluation and diagnostic analyses, including final human-annotated class labels.

## Replication
1. Run `analysis.do` in Stata to reproduce regression results.
2. Run `annotation_evaluation.ipynb` to reproduce summary statistics and classification evaluation results.

All files should remain in the same working directory for replication.