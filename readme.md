- 최근 : [simpleForm_v1.1](https://codepen.io/do-hyung-kim/pen/rQmBZM)

#### 1. __Intro__

```markdown
	- 목표 : ui 통한 html 생성
	- 방법 : json -> html
```

- - -

#### 2. __Current Progress__

```markdown
	- 2018.11.15 : 단순  submit 용도의  form-rendering 해주는 js 골격 [/static/js/custom/render/form/renderSimpleForm.js]
	- 2018.11.15 : form generating 도와주는 페이지 sample [/view/render/form/simpleForm.jsp]
```

- - -

#### 3. __Dependencies__

```markdown
	1. js
		- jquery-ui.min.js	[1.11.4]
		- bootstrap.min.js 	[3.3.2]
		- jquery.min.js    	[latest]
	2. css
		- jquery-ui.css		[1.11.4]
		- bootstrap.min.css	[3.3.2]
```

- - -

#### 4. __Example Json[renderSimpleForm.js]__

```markdown
	var sampleJson = {
		tableInfo : {
			td : [
				{row : 0, sort_pos : 1, name : 'foo', label: 'foo label',showLabel : true, type: 'text',style:'min-						width:600px;'},
				{row : 0, sort_pos : 2, name : 'bar', label: 'bar label',showLabel : true, 									type:'textArea',style:'margin-right:2px;'},	
			],
			th : [
				{mainLabel : 'sampleForm row1 title' , explainHtml : 'row1 explained'},
			]
		},
		pageInfo : [{
			pageTitle : 'this is a sample form page',
			formTitle : 'this is a sample form title',
			xmlId     : 'someIdMappingBld',
			saveButtonText	: 'saveMe',
			saveAction : function(){
				console.log('save action complete')
			},
		}]
	};	
```

- - - 

#### 5. __Parameters considered__

```markdown
	1) td
		- row 		: form 의 row
		- sort_pos	: rowspan 될 경우 고려.
		- name		: 해당 form 에서의 element의 name
		- label		: 설명 label
		- showLabel	: 설명 보여주기 여부
		- type		: (현재) select, text, number, textArea
		- style		: style 속성 반영
		- class		: class 속성 append
		- attributes	: attributes 속성 반영
		- select-option : ajax(미반영, success에서 append하도록 설정) , non-ajax
	2) th
		- mainLabel	: tr 의 대표 Label
		- explainHtml	: td에 div형태로 append되는 tr에 대한 상세설명
	3) pageInfo
		- pageTitle	: 페이지 설명
		- formTitle	: form 설명
		- xmlId		: bld id
		- saveButtonText: save button value
		- saveAction	: default는 controller 의 '저장'을 호출하도록 설정.
```
---

#### 6. __simpleForm.jsp__

```markdown
	1) 목적
		: ui 를 통해, renderSimpleForm.js 에서 이용할 수 있는 json 객체 생성.
	2) 설명
		: <1> renderSimpleForm.js 에 정의된 TemplateHandler 객체는 3가지 object가 정의되어야한다 ; 'td' , 'th', 'pageInfo'
		  <2> 3가지 object를 정의하기 위한 3가지 form이 존재
		  <3> form에서 값을 셋팅 -> [button]클릭 -> [textArea]에서 결과확인 및 수정 [3개의 form에 대해서 작업]
		  <4> [button:전체생성]을 통해, json-object 와 render된 form-html의 string값 확인 및 출력물 화면으로 view
```

- - -
