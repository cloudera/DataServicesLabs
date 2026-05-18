# Lab 4: Test, Monitor and Deploy Workflows

## Objectives

- [ ] In this Lab, we will test our Agentic Workflow, Monitor it and Deploy it as an Application

## Lab Steps
* Click on your workflow in edit mode from the home page

![edit_workflow](./edit_workflow.png)
* Click on the capability description and add the below text into the text box under Capability guide

```text {.prompt-block}
The **“Air Aware”** workflow is designed to perform a comprehensive analysis of air quality for specified locations over a defined date range. The workflow consists of multiple specialized agents and tasks that collaborate to achieve this objective.

The workflow begins by retrieving the bounding box coordinates for each specified location. These coordinates are then used to collect historical weather data, including factors that may influence air quality such as temperature, wind speed, and precipitation.

At the same time, air quality data is retrieved from OpenAQ, with a focus on any specific parameters requested by the user.

The collected data is then analyzed to identify:
- Air quality trends
- Relevant average values
- Potential correlations between weather conditions and air quality

Finally, a detailed report is generated for each location, summarizing the air quality conditions during the specified period, along with key findings and notable observations related to weather patterns.

Example User Input:
Can you provide an air quality report for Seoul from January 1, 2025, to January 3, 2025, focusing on the PM2.5 parameter?

```

![ai_studio_update_capability_guide](./ai_studio_update_capability_guide.png)

* Click on `Save & Next` until you reach the _Configure_ step in the workflow as shown below.

![ai_studio_configure_workflow](./ai_studio_configure_workflow.png)

* Enter the API Key you created from the Open AQ website in step [OpenAQ API Access Setup](./README.md). Click `Save & Next`


* Test the workflow by adding the following text in `user_input` text box below

```text {.prompt-block}
Can you provide an air quality report for Sydney, Australia  between 01.Jan.2025 to 03.Jan.2025 focussing on pm25 parameter?
```

![ai_studio_test_workflow](./ai_studio_test_workflow.png)

* Click on the `Monitoring` Icon Tab to monitor your workflow using Phoenix

![ai_studio_monitoring](./ai_studio_monitoring.png)

* You should be able to use Phoenix to monitor your workflow by clicking on the name of your Project as shown below.

![ai_studio_monitoring_project](./ai_studio_monitoring_project.png)

![ai_studio_monitoring_project_summary](./ai_studio_monitoring_project_summary.png)

* Check the workflow for each tool. For example the below shows the workflow for the Input Parser Agent, which has used the tool to parse the user input

![ai_studio_monitoring_trace](./ai_studio_monitoring_trace.png)

*  If the Workflow has executed properly, you should be able to see the output below as a final Air quality report the user is expected to
get.

![ai_studio_workflow_final_report](./ai_studio_workflow_final_report.png)

* Click on `Save & Next`, and first save your workflow as a Template and then `Deploy`.

![ai_studio_workflow_deploy](./ai_studio_workflow_deploy.png)

!!! note 
    It may take between 5-10 minutes to deploy your application

* You may need to open the workflow again and click on the `Actions` Menu item to deploy.

![ai_studio_workflow_actions_deploy](./ai_studio_workflow_actions_deploy.png)

* Once deployed successfully, you should be able to see the workflow in the main Deployed Workflows section as below.

![ai_studio_deployed_workflows](./ai_studio_deployed_workflows.png)

* Now let us run this Deployed workflow just as a normal user would . Click on the application link as shown below

![ai_studio_run_deployed_workflow](./ai_studio_run_deployed_workflow.png)

* This should open a UI Page below, let us test with user_input comparing Air Quality of 3 cities by entering the following input

```text {.prompt-block}
Can you provide an air quality report for Melbourne between 01.Jan.2025 to 03.Jan.2025 focussing on pm25 parameter
```

![ai_studio_input_deployed_workflow](./ai_studio_input_deployed_workflow.png)

* After a few minutes you should be able to get a complete Air Quality report (partially shown in the screenshot below)

![ai_studio_deployed_workflow_output](./ai_studio_deployed_workflow_output.png)

* Scroll down to download the entire report on your laptop.

## Learning Notes

- [x] In this lab we learnt how to test our Agentic Workflow, Monitor it and Deploy it as an Application

**:rocket: We have now concluded Lab 4 :rocket:**

**:rocket: This concludes our Hands on Workshop :rocket:**
