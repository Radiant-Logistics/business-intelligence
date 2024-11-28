# business-intelligence
This repo contains all code used for dashboards released in the Business Intelligence workspace on the PowerBI webservice (this is essentially the production environment). It also contains scripts used for future automation via Aiflow. 

Materials in this repo include reusable code for the following tools/technology: 

Dashboards
- Source Data: M Language scripts to clean data in PowerQuery
- Data Model: M landguage  scripts for manipulating cleaned data for reporting
- DAX measures: creation of calculated measures used to build out the visuals

Airflow Docker
- proof of concept testing (local standup of the Airflow)
- likely outdated and need be review

There are two branches for this repo: prd and dev. All work must be committed to dev and undergo a code review before merging over to prd. Start by cloning this repo and working under the dev branch. When ready, a pull request can be created to merge changes from the dev branch to prd branch. 