module top_module (
	input [15:0] scancode,
	output reg left,
	output reg down,
	output reg right,
	output reg up
);
	
	always @(scancode) begin
		case(scancode)
			16'he06b: left = 1;
			default: left = 0;
		endcase
		
		case(scancode)
			16'he072: down = 1;
			default: down = 0;
		endcase
		
		case(scancode)
			16'he074: right = 1;
			default: right = 0;
		endcase
		
		case(scancode)
			16'he075: up = 1;
			default: up = 0;
		endcase
	end
	
endmodule
