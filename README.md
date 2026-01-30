# Airline Passenger Satisfaction  

## From Passenger Feedback to Actionable Insights

## Project Overview
This project was developed as the final capstone project for the Ironhack Data Analytics Bootcamp (January 2026) by Ghazal Hassanzadeh.

Using U.S. airline passenger satisfaction data, the project investigates the key drivers of satisfaction, the relative impact of service quality versus operational disruptions, and how airlines can focus on high-impact improvements rather than broad, inefficient changes.

The project combines Python, SQL, and Tableau to deliver an end-to-end, business-oriented data analysis with a strong emphasis on interpretability and decision-making.

---

## Dataset Overview

### Dataset Source
- Name: Airline Passenger Satisfaction  
- Source: Kaggle  
- Link: https://www.kaggle.com/datasets/teejmahal20/airline-passenger-satisfaction  

### Dataset Description
The dataset is based on a passenger satisfaction survey conducted in the U.S. airline industry. Each row represents one passenger journey and combines passenger characteristics, flight information, service quality ratings, and an overall satisfaction outcome.

### Target Variable
- Satisfaction: Satisfied vs Neutral/Dissatisfied

---

## Data Content Overview
The dataset includes the following categories of variables:

- **Passenger characteristics** (e.g. age, gender, customer type)

- **Flight and travel details** (e.g. class, type of travel, flight distance, departure and arrival delays)

- **Service quality ratings**

  Numerical scores (typically on a 0–5 scale) for key service areas such as:
  - Seat comfort
  - Inflight entertainment
  - Food and drink
  - On-board service
  - Online booking and check-in

- **Target variable**
Overall passenger satisfaction, indicating whether a passenger was satisfied or not satisfied.

---

## Research Questions and Hypotheses

RQ1: What really drives passenger satisfaction?  

RQ2: Do delays matter more than service quality?  

RQ3: Do different passengers value different things?  

RQ4: Are airlines investing in the right service improvements?  

RQ5: Can dissatisfaction be predicted early?  

RQ6: How can airlines turn insight into action?  

H1 — Service quality differs between satisfied vs dissatisfied

H2 — High service quality can offset the negative impact of delays

H3 — Different passenger segments value different things

H4 —Service quality improvements show diminishing returns

---

## Tech Stack
- SQL: data exploration, KPI creation, aggregation  
- Python: EDA, feature engineering, hypothesis testing, predictive modeling  
- Tableau: interactive dashboards and business storytelling  
- Git and GitHub: version control and project documentation  

---

## Methodology

The analysis follows a structured, end-to-end data analytics approach focused on interpretability, business relevance, and actionable insights rather than model complexity.

### Data Preparation
The dataset was imported and validated to ensure consistency and analytical usability. Data types, value ranges, and missing values were checked, and satisfaction labels and service rating scales were standardized where necessary.

### Exploratory Data Analysis
Exploratory analysis was conducted to understand overall satisfaction patterns and distributions. Satisfaction rates were examined across service quality dimensions, delay measures, and passenger characteristics. Comparisons between satisfied and dissatisfied passengers helped identify potential drivers of satisfaction.

### Service Impact Analysis
Service quality ratings were grouped into meaningful score bands to move beyond simple averages. Satisfaction gaps between low and high service quality levels were calculated to quantify the relative impact of different service dimensions on overall satisfaction.

### Delay versus Service Quality Assessment
Passenger satisfaction was analyzed across delay buckets and compared against service quality effects. This step evaluated whether strong service performance can mitigate the negative impact of operational delays and helped assess trade-offs between operational and experiential improvements.

### Passenger Segmentation
Passengers were segmented by customer type, travel type, and class. Satisfaction drivers and delay tolerance were compared across segments to identify heterogeneous preferences and to evaluate whether a single service strategy is sufficient for all passenger groups.

### Early Dissatisfaction Signal Analysis
Lightweight, interpretable analytical models were used to assess whether dissatisfaction signals can be identified using available service ratings and travel information. The focus was on identifying key contributing factors and patterns rather than optimizing predictive accuracy.

### Insight-to-Action Translation
Scenario-based analyses were used to compare targeted service improvements against broad, uniform improvement strategies. Estimated satisfaction gains were evaluated under realistic operational and budget constraints to support practical decision-making.


---

## Key Insights
- Service quality has a stronger influence on satisfaction than delays  
- Satisfaction gains are concentrated in a small number of high-impact service areas  
- Different passenger segments value different aspects of the flight experience  
- Targeted service improvements deliver higher value than uniform strategies  

---

## Tableau Dashboards
The Tableau dashboard presents interactive views of satisfaction drivers, delay impacts, and passenger segments.

Tableau Public link: https://public.tableau.com/views/Airline_Passenger_Satisfaction_17696185963980/AirlinePassengerSatisfactionKeyDriversandDelayImpact?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link 

---

## Conclusions and Recommendations
Airlines should prioritize improvements in high-impact service areas, tailor strategies to different passenger segments, and use predictive signals to proactively manage passenger dissatisfaction.

---

## Limitations and Future Work

### Limitations
- Satisfaction is self-reported and subjective  
- Results reflect associations, not causal relationships  
- Dataset represents a single airline context  

### Future Work
- Integration of real-time operational data  
- Multi-airline or multi-market comparison  
- Advanced causal or uplift modeling  

---

## Presentation
Final presentation link: add link here

---

