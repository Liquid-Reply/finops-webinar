# Finops Intro

This repository will contain some use-cases, how tools can help us to improve a better cloud control and activate cost awarenesses on your projects.

# Components
## General best practices
We will point out, how you should create and manage your cloud resources to get a better overview and fit all requirements that are used by e.g. cloud custodian. In this repository the best practices are implemented in terraform.

## Cloud Custodian
Cloud Custodian will be used to show, how you can reduce your cloud costs, enforce specific compliance policies, etc.

## Infracost
Infracost will be used to show, how we can make project participants aware of changes they are implementing.

# Use-Cases
## Tags/Labels
Tags or labels will help you to set up good cloud infrastructure. Typcial tags are e.g. owner, environment, budget 
The owner tag will help you to:
- Send alerts to the owner (security problems, rightsizing recommendations, etc.)
- Charge the owner for the specific resource
  
The environment tag will enable you to:
- Turn off the environment on the weekend or in the night (e.g. dev/test environments)
- Turn off the environment in holiday times (e.g. christmas)
  
The budget tag will enable you to:
- Turn off environments if the budget is exceeding
 
# Used projects
https://github.com/cloud-custodian/cloud-custodian  
https://github.com/infracost/infracost  
https://github.com/terraform-google-modules  
 