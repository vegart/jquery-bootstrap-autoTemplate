(function(jQuery,$,document){ 

	var $ = jQuery;

			
	var TemplateHandler = function(pObj){
			
		this.renderAt = pObj.formId;
		this.xmlId    = pObj.xmlId;
		
		this.tableInfo= {
			td : [],
			th : [],
		};
		this.pageInfo		= [{
			pageTitle 		: '',
			formTitle 		: '',
			submit 			: 'somecontroller.extension?someCommand=saveTemplate',
			saveButtonText	: '저장',
			saveAction 		: function(){
				$.ajax({
					url		: this.submit,
					data	: $('#' + pObj.formId).serializeArray(),
					success	: function(rcvObject){
						console.log('do something on success')
					},
					error	: function(xhr){
						console.log('do something on error')
					}
				});
			}
		}];
		
		this.rendered = {
			table : ''
		}
	  
	  return this;
	};

	TemplateHandler.prototype.setTableInfo = function(tableInfoObj){
		var $this = this;
		
		$this.tableInfo.td = tableInfoObj.td;
		$this.tableInfo.th = tableInfoObj.th;
		
		return $this;
	}

	TemplateHandler.prototype.setPageInfo = function(pageInfoObj){
		var $this 		= this;
		var $pageInfo	= $this.pageInfo[0];
		
		$pageInfo.pageTitle		= pageInfoObj.pageTitle;
		$pageInfo.formTitle 	= pageInfoObj.formTitle;
		$pageInfo.submit 		= $pageInfo.submit + '&xmlId='.concat(pageInfoObj.xmlId);
		
		var definedButtonText	= pageInfoObj.saveButtonText;
		var definedsaveAction	= pageInfoObj.saveAction;
		
		if(definedButtonText)
			$pageInfo.saveButtonText = definedButtonText;
			
		if(definedsaveAction)
			$pageInfo.saveAction 	= definedsaveAction;
		
		$this.pageInfo = [$pageInfo];
		
		return $this;
	}

	TemplateHandler.prototype.render = function(p_objectOrId){
		var $this	= this;
		var $f		= $('#' + $this.renderAt);
		
		$this = $this.renderTable().renderContainer(p_objectOrId);
				
		$( ".js-date-picker",$f ).datepicker({});
    
		
		return $this;
	}

	TemplateHandler.prototype.renderContainer = function(p_objectOrId){
		var $this	= this;
	  
		var $container	= {};
		
		if(typeof p_objectOrId === 'string')
		{
			$container = $('#'+p_objectOrId);
		}
		else if(typeof p_objectOrId === 'object')
		{
			$container = $(p_objectOrId);
		}
		else
		{
			throw 'parameter from render() or renderContainer() is not an object or an id string.';
		}
		
		var $pageInfo = $this.pageInfo[0];
		
		var _formHtml	= '<div class="form-group  text-center" >';
		_formHtml		+= '<span><h3>'+ $pageInfo.formTitle + '</h3></span>';
		_formHtml		+= '</div>';
		
		$container.prepend(_formHtml);
		
		var _titleHtml	= '<div class="form-group">';
		_titleHtml		+= '<span><h2>'+ $pageInfo.pageTitle+ '</h2></span>';
		_titleHtml		+= '</div>';
		
		$container.prepend(_titleHtml);
		
		var _saveButtonHtml = '<div class="form-group pull-right">';
		
		var saveButtonId	= 'btnSave'.concat($this.xmlId);
		_saveButtonHtml		+= '<input type="button" value="'+ $pageInfo.saveButtonText +'" id="' + saveButtonId + '" class="btn-primary form-control" />'
		_saveButtonHtml		+= '</div>';
		
		$container.prepend(_saveButtonHtml);
		
		$('#' + saveButtonId).on('click',function(){
		  $pageInfo.saveAction();
		});
		
		return $this;
	}

	TemplateHandler.prototype.renderTable = function(){
		
		var $this	= this;
		var $f		= $('#' + $this.renderAt), f= $f[0];
		
		var tableInfo		= $this.tableInfo;
		var tdArray			= tableInfo.td;
		var thArray			= tableInfo.th;
		
		var _tableHtml	= '<div class="form-group form-inline table-responsive" style="font-size:12px;"><table class="table table-bordered table-hover" >';
		
		//create ColGroup
		_tableHtml		+= '<colgroup><col width="20%"><col width="80%"></colgroup><tbody>';
		
		thArray.forEach(function(e,i){
			//해당 row와 연관된 td objects.
			var relevantTdArray = tdArray.filter(function(eachTd){return eachTd.row == i});
			
			//sort_pos의 max값 만큼 rowspan해주기.
			var rowSpan	= Math.max.apply(null,relevantTdArray.map(function(eachTd){return eachTd.sort_pos}));
			
			//2. td 그려주기
			var pos	= 1;
			for(pos=1; pos < rowSpan+1; pos++)
			{
				_tableHtml	+= '<tr>'; 
				if(pos == 1)
				{
					//1. th 그려주기.
					_tableHtml	+= '<th rowspan="'+rowSpan+'" style="white-space: initial;"><div>'+e.mainLabel+'</div><div>' +e.explainHtml+'</div></th>';
				}
			
				_tableHtml		+= '<td style="height: 100%;">';
				
				var currentRowObjects = relevantTdArray.filter(function(eachTd){return eachTd.sort_pos == pos});
				
				currentRowObjects.forEach(function(eachCurrentRowObj){
					
					var defaultClass	= 'form-control ';
					
					var inputType 		= eachCurrentRowObj.type;
					var showLabel 		= eachCurrentRowObj.showLabel;
					var elemName		= eachCurrentRowObj.name;
					var isRequired		= eachCurrentRowObj.required;
					var appendClass		= eachCurrentRowObj.class ? defaultClass+ eachCurrentRowObj.class : defaultClass;
					var selectOptions	= eachCurrentRowObj.options;
					var style			= eachCurrentRowObj.style;
					
					var customAttributeArray	= eachCurrentRowObj.attributes;
					
					if((showLabel || showLabel === 'true') && inputType !== 'button')
					{
						_tableHtml	+= '<label class="form-control"  style="width:150px;margin-right:2px;border:0;word-wrap: break-word;height:100%;">' + eachCurrentRowObj.label + '</label>';
					}
					
					//1.customAttribute 할당
					var customAttributeString	= '';
					
					if(customAttributeArray && $.isArray(customAttributeArray))
					{
						customAttributeArray.forEach(function(eachAttribute){
							customAttributeString	+= eachAttribute.key + '=' + '"' + eachAttribute.value + '" ';
						});
					}
					
					//2. required속성 할당
					var requiredString	= ((isRequired || isRequired === 'true') ? ' required ' : ' ' );
					
					//3. style 속성 할당
					var styleString		= style ? 'style="'.concat(style,'" ') : ' ';
					
					var attributeRequiredAndStyleString	= customAttributeString + requiredString + styleString;
					
					if(inputType === 'select')
					{
						if(!selectOptions.isAjax)
						{
							_tableHtml		+= '<select name="'+ elemName +'" class="'+ appendClass +'" ' + attributeRequiredAndStyleString + '>';
							selectOptions.array.forEach(function(eachOption){
								_tableHtml	+= '<option value="'+ eachOption.key +'">';
								_tableHtml	+= eachOption.value;
								_tableHtml	+= '</option>';
							});
						
							_tableHtml		+= '</select>';
						}
						else
						{
							_tableHtml		+= '<select name="'+ elemName +'" class="'+ appendClass +'" '+ attributeRequiredAndStyleString + '>';
							console.log('MAKE AJAX CALL TO APPEND OPTIONS WITH URL DEFINED');
							console.log(selectOptions);
							_tableHtml		+= '</select>';
						}
					}
					else if(inputType === 'textArea')
					{
						_tableHtml	+= '<textArea name="'+ elemName +'" class="'+ appendClass +'" ' + attributeRequiredAndStyleString + '>';
						_tableHtml	+= '</textArea>';
					}
					else if(inputType === 'date')
					{
						appendClass += ' js-date-picker';
						_tableHtml	+= '<input type="text" name="'+ elemName +'"  class="'+ appendClass +'" placeholder="'+ eachCurrentRowObj.label +'"'  + attributeRequiredAndStyleString + '/>';
					}
					else if(inputType === 'button')
					{
						_tableHtml	+= '<input type="button" name="'+ elemName +'"  class="'+ appendClass +'" value="'+ eachCurrentRowObj.label +'"'  + attributeRequiredAndStyleString + '/>';
					}
					else
					{
						_tableHtml	+= '<input type="'+ inputType +'" name="'+ elemName +'"  class="'+ appendClass +'" placeholder="'+ eachCurrentRowObj.label +'"'  + attributeRequiredAndStyleString + '/>';
					}
					
				});
				_tableHtml	+= '</td>';
				_tableHtml	+= '</tr>';
			};
		});
				   
		_tableHtml			+= '</tbody></table></div>';
		
		$this.rendered.table = _tableHtml;
		$f.append(_tableHtml);
		
		return $this;
	}
})(jQuery,$,document)
