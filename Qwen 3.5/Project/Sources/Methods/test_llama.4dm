//%attributes = {}
var $cases : Collection
$cases:=[]

var $OpenAITool : cs:C1710.AIKit.OpenAITool
$OpenAITool:=cs:C1710.AIKit.OpenAITool.new({\
type: "function"; \
function: {\
name: "get_current_weather"; \
description: "指定した都市の現在の天候を返します。"; \
parameters: {\
type: "object"; \
properties: {\
location: {type: "string"; description: "都道府県および都市の名前。例: 東京都渋谷区"}\
}; \
unit: {type: "string"; enum: ["摂氏"; "華氏"]}; \
required: ["location"]\
}}})

var $messages : Collection
$messages:=[]
$messages.push({role: "user"; content: "今日のシブヤのお天気はどんな感じ？"})

var $case : Object
var $name; $model : Text

$name:=$case.provider

var $ChatCompletionsParameters : cs:C1710.AIKit.OpenAIChatCompletionsParameters
$ChatCompletionsParameters:=cs:C1710.AIKit.OpenAIChatCompletionsParameters.new({model: $model})

//parameters for tool calling
$ChatCompletionsParameters.temperature:=0
$ChatCompletionsParameters.tool_choice:="auto"
$ChatCompletionsParameters.tools:=[$OpenAITool]

var $OpenAI : cs:C1710.AIKit.OpenAI
$OpenAI:=cs:C1710.AIKit.OpenAI.new()
$OpenAI.baseURL:="http://127.0.0.1:8080/v1"

var $ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult
$ChatCompletionsResult:=$OpenAI.chat.completions.create($messages; $ChatCompletionsParameters)
If ($ChatCompletionsResult.success)
	If ($ChatCompletionsResult.choice.finish_reason="tool_calls")
		var $reasoning_content : Text:=$ChatCompletionsResult.choice.message["reasoning_content"]
		var $tool_calls : Collection:=$ChatCompletionsResult.choice.message.tool_calls
		var $tool_call; $arguments : Object
		var $function : 4D:C1709.Function
		var $current_weather : Text
		For each ($tool_call; $tool_calls)
			$function:=Formula from string:C1601($tool_call.function.name)
			$arguments:=JSON Parse:C1218($tool_call.function.arguments)
			$current_weather:=$function.call($OpenAI; $arguments)
		End for each 
	End if 
End if 