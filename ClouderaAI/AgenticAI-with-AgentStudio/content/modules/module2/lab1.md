# Lab 1: Create Templates and workflows in Agent Studio

## Objectives

In this Lab we will use Agent Studio to create the Air quality Investigator System , we will learn:

- [ ] Create workflows in Agent Studio
- [ ] Learn how to set up 5 agents, tasks and tools


## Lab Steps

!!! warning "Important"
    Please ensure you use `aistudio-llm-model` as your LLM when creating agents

* Click on Agent Studio from the AI Studios Menu item on CAI Left Menu. You should see the Landing Page below.

![agent_studio_ai_studio](./agent_studio_ai_studio.png)

* Click on Get Started Button to come to the Home Page for Agent Studio.

![ai_studio_getting_started](./ai_studio_getting_started.png)

* Click on `Create` button to launch a Workflow Template wizard.

* Create a New template and give a name `Air Aware - XXX` ( user your name)


![ai_studio_template](./ai_studio_template.png)

* Click on `Create Workflow` after entering the name.

* In the next screen , ensure "Conversational" and "Manager Agent" are disabled. We will discuss what these settings mean.

![ai_studio_cabability](./ai_studio_cabability.png)

* Click on Create or Edit Agents using the template here. We will be creating a total of 5 Agents using this template

![ai_studio_create_agent](./ai_studio_create_agent.png)

* **Agents Definition:** Use the cell values below against to define each agent. Copy the values in each cell against each type of agent in the code.

!!! warning "Important"
    Please ensure you use `aistudio-llm-model` as your LLM when creating agents

| Agent | Role | Backstory | Goal |
| :---- | :---- | :---- | :---- |
| input_parser_agent | 입력 데이터 파서 | 사용자가 제공한 자연어 입력을 공기 품질 분석에 필요한 구조화된 파라미터로 변환한다. | 사용자 질문에서 구조화된 정보를 효율적으로 추출하는 어시스턴트. |
| bounding_box_retriever | 지리 공간 데이터 전문가 | 지정된 위치에 대한 바운딩 박스 좌표를 조회한다. | 지리 정보 검색 및 공간 데이터 분석 전문가. |
| weather_data_integrator | 과거 기상 데이터 전문가 | 지정된 위치와 날짜에 대한 간단한 과거 기상 요약 정보를 조회한다. | 과거 기상 데이터 분석의 전문 연구자. |
| air_quality_retriever | 대기질 데이터 조회자 | 지정된 위치와 날짜 범위에 대해 OpenAQ에서 대기질 데이터를 가져온다. | 대기질 데이터 접근 및 조회에 특화된 전문가. |
| air_quality_analyst | 대기질 분석가 | 대기질 데이터와 과거 기상 데이터를 분석해 리포트를 한글로 생성한다. | 대기질 분석 및 기상학 연구 경험이 풍부한 분석가.  |

* We will not use any Tools at this point, we will add the tools later. Also we will not use any MCP Server at this point  

* Create the 5 Agents based on the data above.

* You can experiment with "Generate with AI" option to generate your prompt.

* After this you should be able to see 5 Agents as below.

![ai_studio_defined_agents](./ai_studio_5_Agents_workflow.png)

## Learning Notes
- [x] Create workflows in Agent Studio
- [x] We have learnt how to start using AI Studios and create Agents

**:rocket: We have now concluded Lab 1 :rocket:**
