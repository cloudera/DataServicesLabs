# Lab 2: Create Tasks in Agent Studio

## Objectives

- [ ] Create Tasks for each of the Agents
- [ ] Create Dynamic Inputs ( Imputation ) for the input from our input_parser

## Lab Steps

Now let us define the tasks for our Agents to work on.

* Start with the Tasks Screen shown below

![ai_studio_edit_tasks](./ai_studio_edit_tasks.png)

| Description | Agent | Expected Output |
| :---- | :---- | :---- |
| 사용자 입력: {user_input}을 파싱한다. InputParserTool을 사용하여 위치(locations), 시작 날짜(start date), 종료 날짜(end date), 그리고 대기질 파라미터(air quality parameters)를 추출한다. | input_parser_agent | 사용자 입력에서 추출된 ‘locations’, ‘start_date’, ‘end_date’, ‘aq_parameters’가 담긴 딕셔너리 |
| 다음 위치들 각각에 대해 ‘bounding_box_extractor’ 도구를 사용해 바운딩 박스 좌표를 조회한다. 각 위치에 해당하는 바운딩 박스를 반환한다. | bounding_box_retriever | 각 위치에 대한 바운딩 박스 좌표(south, west, north, east)를 담은 딕셔너리 또는 리스트 |
| 다음 위치 각각에 대해 바운딩 박스(south, west, north, east), start_date, end_date를 사용하여 weather tool로 해당 날짜 사이의 핵심 과거 기상 요약 정보를 조회한다. 대기질에 영향을 줄 수 있는 주요 기상 요소(예: 기온, 바람, 강수량)에 집중한다. | weather_data_integrator | 각 위치별 과거 기상 조건 요약을 담은 딕셔너리 또는 리스트 |
| air_quality_tool을 사용하여 각 위치의 대기질 데이터를 start_date부터 end_date까지 가져온다. 반드시 각 위치의 바운딩 박스만 사용해야 한다. aq_parameters 속성이 특정 파라미터를 지정한 경우 해당 값들에 집중한다. 결과는 pandas DataFrame으로 반환한다. | air_quality_retriever | 지정된 위치, 날짜, 파라미터에 대한 대기질 데이터가 담긴 pandas DataFrame |
| 제공된 대기질 데이터(pm10, value, units, date, location 등)를 위치별/날짜별로 분석한다. 같은 기간의 과거 기상 정보(기온, 바람, 강수량, 습도)를 함께 고려한다. 대기질 추세를 파악하고, 관련 평균값을 계산하며, 기상 조건이 대기질에 미친 잠재적 영향이나 상관관계를 논의한다. 각 위치별 대기질 상황을 요약한 상세 보고서를 작성하되, 핵심 인사이트와 기상 패턴 관련 관찰 내용을 포함한다. 여러 위치 간 비교도 포함하고, 신뢰할 수 있는 지식 기반을 활용해 전반적 대기질에 대한 의견도 제시한다. | air_quality_analyst | 각 위치에 대한 대기질 분석 보고서. 추세, 평균값, 기상 조건과의 관계 분석을 포함하며, 보고서 상단에 Summary(요약), 마지막에 Conclusion(결론)을 포함 |

* Click on `Save and Next` to go to the Configurations Page.  

* Set the Configurations to `1000` New Tokens as below.

![ai_studio_workflow_config](./ai_studio_workflow_config.png)

* Let us now test the workflow. With the following user_input

    ```
    2025년 1월 1일부터 2025년 1월 3일까지 서울의 대기질 보고서를 초미세먼지 2.5 파라미터 중심으로 제공해줄 수 있나요?
    ```

* As you can see the LLM is now hallucinating and generating data for New York and Los Angeles in Oct 2023 etc.

![ai_studio_workflow_test_hallucinating](./ai_studio_workflow_test_hallucinating.png)

!!! info
    While we have set up Agents and Tasks, the default LLM lacks the ability for us to build a **Trustworthy Investigative system**.

    In the next section we will use Custom Tools to get us a more accurate and trust worthy report

## Learning Notes

In this Lab

- [x] we learnt how to set up Tasks and associate them with Agent.

- [x] We also saw that only using Prompts lacks the ability to generate a good quality output  

**:rocket: We have now concluded Lab 2 :rocket:**
