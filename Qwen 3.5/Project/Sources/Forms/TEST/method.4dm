var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		var $LLM : cs:C1710.LLM
		$LLM:=cs:C1710.LLM.new(\
			Folder:C1567(fk home folder:K87:24).folder(".GGUF").folder("Qwen3.5-0.8B"); \
			"Qwen3.5-0.8B-Q4_K_M.gguf"; \
			"unsloth/Qwen3.5-0.8B-GGUF"; 32000; 1; 2; \
			Current form window:C827; Formula:C1597(OnLLM))
		
		OBJECT SET VISIBLE:C603(*; "progress"; Not:C34($LLM.available))
		OBJECT SET VISIBLE:C603(*; "btn.@"; $LLM.available)
		
End case 