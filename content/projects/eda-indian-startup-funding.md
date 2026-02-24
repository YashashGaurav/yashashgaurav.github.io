---
title: "EDA on Indian Startup Funding"
date: 2022-10-16
draft: false
tags: ["Python", "Jupyter Notebook", "Altair", "GeoPandas"]
summary: "Exploratory data analysis on Indian startup funding (2021-2022) — a CMU college project analyzing trends for entrepreneurs and VC fund managers"
showToc: true
params:
  context: "college"
  projectURL: "https://github.com/YashashGaurav/EDA-Indian-Startup-Analysis"
  demoURL: "https://www.youtube.com/watch?v=n-omO5mY6kY"
  status: "completed"
---

# Analyzing India's Startup Funding Landscape

{{< youtube n-omO5mY6kY >}}
</br>

## The Why

India's startup ecosystem has been growing rapidly, but the data behind it — which sectors attract funding, which cities are emerging hubs, who the key investors are — is rarely surfaced in an accessible way. We wanted to change that. This project was built for entrepreneurs looking to enter the Indian market and VC fund managers trying to understand where capital is flowing, giving them a data-driven lens to make more informed decisions.

## The What

We sourced two Kaggle datasets covering Indian startup funding from 2021 through April 2022, cleaned and merged them, and built a suite of interactive visualizations to explore the landscape. Key aspects of the project:

- **Interactive Visualizations** — Built with Altair, enabling drill-down exploration of funding trends by sector, stage, and investor
- **Geographic Analysis** — Used GeoPandas to map funding distribution across Indian cities and states, revealing emerging startup hubs beyond Bangalore and Mumbai
- **Trend Analysis** — Tracked funding amounts and deal counts over time to identify growth sectors and market momentum
- **Google Colab** — Fully runnable in the browser, making the analysis reproducible without any local setup

## Team

Built by [Yashash Gaurav](https://github.com/YashashGaurav) (Me) and [Siddharth Sai](https://www.linkedin.com/in/siddharthsai/) — a project for Prof. [Raja Sooriamurthi](https://www.cmu.edu/mscf/people/faculty/raja.html)'s [Data Science and Big Data](https://www.heinz.cmu.edu/current-students/courses/95-885) course at Heinz College, Carnegie Mellon University.
