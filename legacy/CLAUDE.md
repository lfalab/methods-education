# CLAUDE.md — Legacy Materials Directory

This directory contains teaching materials from a previous version of this course taught at UCSD. These materials are **read-only reference sources** used as starting points when creating new content for the current KCL course.

Claude must **never modify files in this directory** (except this CLAUDE.md file, if instructed).

---

## Purpose

The slide decks, activities, and videos on the Quarto website are created iteratively with Claude. The typical workflow is:

1. Read relevant legacy materials (slides, transcripts, reference pages) on a topic
2. Use them as springboards for new `.qmd` content — adapting the pedagogical structure, explanations, and teaching sequence
3. Change the canonical example to use KCL-era datasets

Legacy materials capture the **pedagogical reasoning** and **teaching sequence** developed over previous iterations of the course. They are valuable for their structure and explanations, not for their specific examples or data.

---

## Canonical Example Shift

The UCSD materials used **California county-level data** as the running example (e.g., Trump vote share predicted by percent white population, income changes).

The KCL materials use **UK datasets**:

| Dataset | Example |
|---|---|
| Brexit Regional | Leave vote share predicted by education, import shock, unemployment, immigration |
| British Election Study (BES) 2024 | Vote choice, ideology, newspaper readership, gender |
| Quality of Government (QoG) 2026 | Cross-national comparisons: democracy, corruption, turnout, inequality |
| National Student Survey (NSS) 2025 | Student satisfaction distributions |

When creating new content from legacy materials, always adapt examples to use these datasets. The datasets are in `shared-project-folder/data-raw/`.

---

## Directory Structure

### `slides/`

PDF exports of UCSD lecture slide decks, numbered L01–L19:

| File | Topic |
|---|---|
| L01_Quant_Qual.pdf | Quantitative vs qualitative methods |
| L02_Hypotheses.pdf | Hypotheses |
| L03_Measurement.pdf | Measurement |
| L05_Data_Frames.pdf | Data frames |
| L06_Descriptive.pdf | Descriptive statistics |
| L07_Datasets.pdf | Datasets |
| L08_Samples.pdf | Samples and sampling |
| L09_Hypothesis_Tests.pdf | Hypothesis tests |
| L10_Confounding.pdf | Confounding variables |
| L12_P-values.pdf | P-values |
| L13_Regression.pdf | Bivariate regression |
| L14_Dummy.pdf | Dummy variables |
| L15_Nominal.pdf | Nominal variables |
| L16_Multivariate.pdf | Multivariate regression |
| L17_Reg_Tables.pdf | Reading regression tables |
| L18_Reg_Advanced.pdf | Advanced regression topics |
| L19_Critical.pdf | Critical interpretation |

### `pages/`

PDF reference pages — longer-form conceptual explanations used as the basis for video slide decks:

| File | Topic |
|---|---|
| Regression-Analysis-Introduction.pdf | Linear functions, bivariate regression basics |
| Regression-R-squared.pdf | R-squared, residual and total sum of squares |
| Multivariate-Regression-Introduction.pdf | Multiple predictors, "holding constant" interpretation, confounding |
| Standard-Error.pdf | Standard error vs standard deviation, significance testing |

### `transcripts/`

Text transcripts of UCSD-era lecture videos. These capture the spoken explanations and are especially useful for understanding how concepts were presented verbally:

| File | Topic |
|---|---|
| Regression-Analysis-Introduction.txt | Regression equation, slope, intercept |
| Regression-Slope.txt | Covariance/variance formula, OLS, residuals |
| Regression R-Squared.txt | Variance explained, reading regression output |
| Regression-Inference.txt | P-values, confidence intervals, factors affecting significance |
| Multivariate-confounding.txt | Confounding definition, multivariate regression as control |
| Reading-regression-tables.txt | Multiple models, star notation, standard errors |

### `activities/`

Classroom activity documents from UCSD:

| File | Topic |
|---|---|
| CA08_Sampling.docx | Sampling activity |
| CA10_Confounding.docx | Confounding variables activity |

### `prompts/`

Planning documents that record the pedagogical reasoning behind how specific weeks were structured:

| File | Topic |
|---|---|
| Week-9-structure.txt | Week 9 structure: confounding as central topic, stop-and-frisk activity |

These are particularly valuable because they capture the **why** behind content decisions — not just what was taught, but the reasoning for the teaching sequence.

---

## How Legacy Materials Map to Current Content

The following table shows how legacy sources were used to create the current Week 8–9 materials (as an example of the workflow):

| Legacy source | Current page |
|---|---|
| `pages/Regression-Analysis-Introduction.pdf` | `slides/videos-concepts/C18-regression-intro.qmd` |
| `transcripts/Regression-Slope.txt` | `slides/videos-concepts/C19-regression-slope.qmd` |
| `transcripts/Regression-Inference.txt` | `slides/videos-concepts/C20-regression-inference.qmd` |
| `pages/Regression-R-squared.pdf` + `transcripts/Regression R-Squared.txt` | `slides/videos-concepts/C21-regression-rsquared.qmd` |
| `transcripts/Multivariate-confounding.txt` | `slides/videos-concepts/C22-confounding.qmd` |
| `slides/L13_Regression.pdf` | `slides/lectures/W08-regression.qmd` |
| `prompts/Week-9-structure.txt` | Structure of `slides/lectures/W09-confounding.qmd` + `activities/A09a-confounding-reverse.qmd` |
| `activities/CA10_Confounding.docx` | `activities/A09a-confounding-reverse.qmd` |

---

## Guidelines for Claude

When creating new content from legacy materials:

- **Read** legacy files for pedagogical structure, flow, and explanations
- **Adapt** examples to use KCL datasets (Brexit, BES, QoG, NSS)
- **Preserve** the teaching progression and conceptual scaffolding
- **Do not** copy text verbatim — rewrite for the new context
- **Do not** modify any legacy files
- **Do not** assume legacy structure maps 1:1 to current weeks — the KCL course reorganised topics
