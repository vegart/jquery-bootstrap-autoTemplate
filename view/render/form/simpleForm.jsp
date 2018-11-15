<head>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"> </script>
	
	<script type="text/javascript">
			var generatedObj = {
		tableInfo : {
			td : [],
			th : []
		},
		pageInfo : [{}]
	}
		
	var createTdObj = {
		tableInfo : {
			td : [
				{row : 0, sort_pos : 1, name : 'row', label: 'form에서의 줄위치',showLabel : true, type: 'number'},
				{row : 0, sort_pos : 2, name : 'sort_pos', label: 'td에서의 줄위치',showLabel : true, type: 'number'},
				{row : 0, sort_pos : 3, name : 'name', label: 'form에서의 name속성',showLabel : true, type: 'text'},
				{row : 0, sort_pos : 4, name : 'label', label: 'name속성에대한label',showLabel : true, type: 'text'},
				{row : 0, sort_pos : 5, name : 'showLabel', label: 'label display 여부',showLabel : true, type: 'select',
					options : {isAjax : false, array : [{key : 'true' , value : '보이기'},{key : 'false' , value : '가리기'}]}},
				{row : 0, sort_pos : 6, name : 'required', label: 'required 설정',showLabel : true, type: 'select',
					options : {isAjax : false, array : [{key : 'true' , value : '네'},{key : 'false' , value : '아니요'}]}},
				{row : 0, sort_pos : 7, name : 'attributes', label: 'html커스텀속성[{key:,value:},..]',showLabel : true, type: 'text',style : 'min-width:50%;',class: 'js-eval'},
				{row : 0, sort_pos : 8, name : 'type', label: 'input타입',showLabel : true, type: 'select',
					options : {isAjax : false, array : [{key : 'select' , value : '설렉트박스'},{key : 'text' , value : '텍스트'},{key : 'number' , value : '숫자'},{key : 'textArea' , value : '텍스트에어리어'},{key : 'date' , value : '날짜'},{key : 'button' , value : '버튼'}]}},
				{row : 0, sort_pos : 9, name : 'class', label: '커스텀클래스 지정',showLabel : true, type: 'text',style : 'min-width:50%;'},
				{row : 0, sort_pos : 10, name : 'style', label: '커스텀style 지정',showLabel : true, type: 'text',style : 'min-width:50%;'},
				
				{row : 1, sort_pos : 1, name : 'optionIsAjax', label: '설렉트박스ajax호출여부',showLabel : true, type: 'select',
					options : {isAjax : false, array : [{key : 'true' , value : '네'},{key : 'false' , value : '아니요'}]}},
				{row : 1, sort_pos : 2, name : 'array', label: '셀렉트url또는optionHtml[selectbox 인 경우에만 해당 : [{key:,value:},..]]',showLabel : true, type: 'text',style : 'min-width:60%;',class: 'js-eval'},
				
			],
			th : [
				{mainLabel : 'tableInfo>td' , explainHtml : '1.tableInfo에 td 오브젝트 json만들기[공통]'},
				{mainLabel : 'select 일때' , explainHtml : 'customize json'},
				
			]
		},
		pageInfo : [{
			pageTitle : '',
			formTitle : 'td json 자동생성',
			xmlId     : 'someTdId',
			saveButtonText	: 'Td rowJson저장',
			saveAction : function(){
				var $textArea	= $('#tdArea');
				var $f			= $('#write-template-tableInfo-td-form'), f= $f[0];
				var formArray 	= $f.serializeArray().filter(function(eachNamedObject){return eachNamedObject.value !== ''});
				
				var optionsDisregardedArray = formArray.filter(function(eachNamedObject){return eachNamedObject.name !== 'optionIsAjax' && eachNamedObject.name !== 'array'});
				var optionsArray			= formArray.filter(function(eachNamedObject){return eachNamedObject.name === 'optionIsAjax' || eachNamedObject.name === 'array'});
				
				var jsonStartString 	= '{';
				var jsonEndString		= '}';
				var _jsonTd = jsonStartString;
				
				optionsDisregardedArray.forEach(function(eachObj){
					var evaledString = $(f[eachObj.name]).hasClass('js-eval') ? '' : '"';
				
					_jsonTd += eachObj.name + ' :' + evaledString + eachObj.value + evaledString + ', ';
				});
				
				if(f['type'].value === 'select')
				{
					_jsonTd += 'options : { ';
				
					optionsArray.forEach(function(eachObj){
						_jsonTd += eachObj.name + ' : ' + eachObj.value + ',';
					});
					
					//array 선언부 끝 ','제거.
					_jsonTd = _jsonTd.substring(0,_jsonTd.length-1);
					
					_jsonTd += '} ';
				}
				_jsonTd += jsonEndString;
				
				var previousTextAreaValue = ($textArea.val() === '') ? $textArea.val() : $textArea.val() + ', \n ';
				$textArea.val(previousTextAreaValue + _jsonTd);
			},
		}]
	}
		
	var createThObj = {
		tableInfo : {
			td : [
				{row : 0, sort_pos : 1, name : 'mainLabel', label: '메인레이블',showLabel : true, type: 'text',style:'min-width:60%;'},
				{row : 0, sort_pos : 2, name : 'explainHtml', label: '레이블상세설명[있는경우,div로append됨]',showLabel : true, type: 'text',style:'min-width:60%;'},
			],
			th : [
				{mainLabel : 'tableInfo>th' , explainHtml : '2.tableInfo에 th 오브젝트 json만들기'},
			]
		},
		pageInfo : [{
			pageTitle : '',
			formTitle : 'th json 자동생성',
			xmlId     : 'someThId',
			saveButtonText	: 'Th rowJson저장',
			saveAction : function(){
				
				var $textArea	= $('#thArea');
				var $f			= $('#write-template-tableInfo-th-form'), f= $f[0];
				var formArray 	= $f.serializeArray().filter(function(eachNamedObject){return eachNamedObject.value !== ''});
							
				var jsonStartString 	= '{';
				var jsonEndString		= '}';
				var _jsonTh = jsonStartString;
				
				formArray.forEach(function(eachObj){
					var evaledString = $(f[eachObj.name]).hasClass('js-eval') ? '' : '"'; // 현재로서는, 해당사항 없음.
				
					_jsonTh += eachObj.name + ' :' + evaledString + eachObj.value + evaledString + ', ';
				});
				
				_jsonTh += jsonEndString;
				
				var previousTextAreaValue = ($textArea.val() === '') ? $textArea.val() : $textArea.val() + ', \n ';
				$textArea.val(previousTextAreaValue + _jsonTh);
			},
		}]
	}
	
	var createPageInfoObj = {
		tableInfo : {
			td : [
				{row : 0, sort_pos : 1, name : 'pageTitle', label: '페이지제목',showLabel : true, type: 'text',style:'min-width:40%;'},
				{row : 0, sort_pos : 2, name : 'formTitle', label: 'form제목',showLabel : true, type: 'text',style:'min-width:40%;'},
				{row : 0, sort_pos : 3, name : 'xmlId', label: '고유id[saveAction override 안하는경우,bld에 mapping되는 xmlId]',showLabel : true, type: 'text',style:'min-width:40%;'},
				{row : 0, sort_pos : 4, name : 'saveButtonText', label: '버튼텍스트',showLabel : true, type: 'text',style:'min-width:40%;'},
				{row : 0, sort_pos : 5, name : 'saveAction', label: 'save함수 override정의',showLabel : true, type: 'textArea',attributes : [{keys:'cols',value:120},{keys:'rows',value:10}] ,class : 'js-eval'},
			],
			th : [
				{mainLabel : 'tableInfo>th' , explainHtml : '3.pageInfo 오브젝트 json만들기'},
			]
		},
		pageInfo : [{
			pageTitle : '',
			formTitle : 'pageInfo json 자동생성',
			xmlId     : 'someThId',
			saveButtonText	: 'pageInfo Json저장',
			saveAction : function(){
				
				var $textArea	= $('#pageInfoArea');
				var $f			= $('#write-template-pageInfo-form'), f= $f[0];
				var formArray 	= $f.serializeArray().filter(function(eachNamedObject){return eachNamedObject.value !== ''});
							
				var jsonStartString 	= '{';
				var jsonEndString		= '}';
				var _jsonPageInfo = jsonStartString;
				
				formArray.forEach(function(eachObj){
					var evaledString = $(f[eachObj.name]).hasClass('js-eval') ? '' : '"'; // 현재로서는, 해당사항 없음.
				
					_jsonPageInfo += eachObj.name + ' :' + evaledString + eachObj.value + evaledString + ', ';
				});
				
				_jsonPageInfo += jsonEndString;
				
				$textArea.val(_jsonPageInfo);
			},
		}]
	}
	
	$(document).ready(function(){
		var tdObj = createTdObj; // td json create 도와주는 object;
	  
		new TemplateHandler({
			formId	: 'write-template-tableInfo-td-form',
			xmlId	: 'someId0',
			}).
			setTableInfo(tdObj.tableInfo).
			setPageInfo(tdObj.pageInfo[0]).
			render('sampleContainer-td');
		
		var thObj = createThObj; // th json create 도와주는 object;
	  
		new TemplateHandler({
			formId	: 'write-template-tableInfo-th-form',
			xmlId	: 'someId1',
			}).
			setTableInfo(thObj.tableInfo).
			setPageInfo(thObj.pageInfo[0]).
			render('sampleContainer-th');
		
		var pageInfoObj = createPageInfoObj; // th json create 도와주는 object;
	  
		new TemplateHandler({
			formId	: 'write-template-pageInfo-form',
			xmlId	: 'someId2',
			}).
			setTableInfo(pageInfoObj.tableInfo).
			setPageInfo(pageInfoObj.pageInfo[0]).
			render('sampleContainer-pageInfo');
		
		$('#btnRender').on('click',function(){
			
			var $textAreas		= $('.js-help-render');
			
			$textAreas.each(function(i,eachTextArea){
		  
				var $eachTextArea	= $(eachTextArea);
				var eachId			= $eachTextArea.attr('id');
				var areaValue		= $eachTextArea.val();
				
				if(eachId.indexOf('td')>-1)
				{
					generatedObj.tableInfo.td	= eval("[".concat(areaValue,"]"));
				}
				else if(eachId.indexOf('th') > -1)
				{
					generatedObj.tableInfo.th	= eval("[".concat(areaValue,"]"));
				}
				else if(eachId.indexOf('pageInfo') > -1)
				{
					generatedObj.pageInfo		= eval("[".concat(areaValue, "]"));
				}
				else
				{
					throw 'oops..! textArea ids should be defined individually containing texts : "td" , "th",  "pageInfo"';
				}
			});
			
			var $targetTextArea		= $('#renderedArea');
			$targetTextArea.val(JSON.stringify(generatedObj));
			
			
			//기존 rendered form 및 parent container 비우기.
			var renderFormId			= 'write-template-rendered-form';
			var renderFormContainerId	= 'sampleContainer-rendered';
			
			var $renderForm	 		= $('#'+renderFormId);
			var $renderContainer	= $('#'+renderFormContainerId);
			
			$renderForm.detach();
			
			$renderForm.empty();
			$renderContainer.empty();
			
			$renderContainer.append($renderForm);
			
			//새로만들기
			new TemplateHandler({
				formId	: renderFormId,
				xmlId	: generatedObj['pageInfo'][0].xmlId,
				}).
					setTableInfo(generatedObj.tableInfo).
					setPageInfo(generatedObj.pageInfo[0]).
					render(renderFormContainerId);
					
			//html 
			var $renderedHtmlArea	= $('#renderedHtmlArea');
			$renderedHtmlArea.val($('#'+renderFormContainerId)[0].outerHTML);
		});
	});
</script>
</head>

<body>
	<div class="container">
		<div class="row form-group form-inline">
			<div class="col-md-12">
				<input type="button" class="btn-primary pull-right form-control" id="btnRender" value = "전체생성"/>
			</div>
			<div class="col-md-6">
				<textArea id="renderedArea" rows="10" cols="2" style="width:100%;"></textArea>
			</div>
			<div class="col-md-6">
				<textArea id="renderedHtmlArea" rows="10" cols="2" style="width:100%;"></textArea>
			</div>
		</div>
		
		<div class="row form-group form-inline">
			<div class="panel table-responsive col-md-12" id="sampleContainer-rendered">
				<form id ="write-template-rendered-form"></form>
			</div>
		</div>
		
		<div class="row form-group form-inline">
			<div class="panel table-responsive col-md-12" id="sampleContainer-td">
				<textArea id="tdArea" rows="10" cols="2" class="js-help-render" style="width:100%;"></textArea>
				<form id ="write-template-tableInfo-td-form"></form>
				
			</div>
		</div>
			
		<div class="row form-group form-inline">
			<div class="panel table-responsive col-md-6" id="sampleContainer-th">
				<textArea id="thArea" rows="10" cols="2" class="js-help-render" style="width:100%;"></textArea>
				<form id ="write-template-tableInfo-th-form"></form>
				
			</div>
			
			<div class="panel table-responsive col-md-6" id="sampleContainer-pageInfo">
				<textArea id="pageInfoArea" rows="10" cols="150" class="js-help-render" style="width:100%;"></textArea>
				<form id ="write-template-pageInfo-form"></form>
				
			</div>
		</div>
		
	</div>
</body>
