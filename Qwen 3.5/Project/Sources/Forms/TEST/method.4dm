var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		var $LLM : cs:C1710.LLM
		
		Case of 
			: (False:C215)  //4B
				
				$LLM:=cs:C1710.LLM.new(\
					Folder:C1567(fk home folder:K87:24).folder(".GGUF").folder("qwen-3.5/4B"); \
					"Qwen3.5-4B-Q4_K_M.gguf"; \
					"unsloth/Qwen3.5-4B-MTP-GGUF"; 32000; 1; 2; \
					Current form window:C827; Formula:C1597(OnLLM))
				
			: (False:C215)  //2B
				
				$LLM:=cs:C1710.LLM.new(\
					Folder:C1567(fk home folder:K87:24).folder(".GGUF").folder("qwen-3.5/2B"); \
					"Qwen3.5-2B-Q4_K_M.gguf"; \
					"unsloth/Qwen3.5-2B-MTP-GGUF"; 32000; 1; 2; \
					Current form window:C827; Formula:C1597(OnLLM))
				
			: (True:C214)  //0.8B
				
				$LLM:=cs:C1710.LLM.new(\
					Folder:C1567(fk home folder:K87:24).folder(".GGUF").folder("qwen-3.5/0.8B"); \
					"Qwen3.5-0.8B-Q8_0.gguf"; \
					"unsloth/Qwen3.5-0.8B-MTP-GGUF"; 32000; 1; 2; \
					Current form window:C827; Formula:C1597(OnLLM))
				
		End case 
		
		OBJECT SET VISIBLE:C603(*; "progress"; Not:C34($LLM.available))
		OBJECT SET VISIBLE:C603(*; "btn.@"; $LLM.available)
		
End case 