module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
  
	reg out1;
	reg out2;
	
	always @(*)
	begin
		if (state[8] || state[9])
			out1 = 1'b1;
		else
			out1 = 1'b0;
		
		if (state[7] || state[9])
			out2 = 1'b1;
		else
			out2 = 1'b0;
		
		case(state)
			10'b0000000001: next_state = 10'b0000000000;
			10'b0000000010: next_state = 10'b0000000001;
			10'b0000000011: next_state = 10'b0000000010;
			10'b0000000100: next_state = 10'b0000000011;
			10'b0000000101: next_state = 10'b0000000100;
			10'b0000000110: next_state = 10'b0000000101;
			10'b0000000111: next_state = 10'b0000000110;
			10'b0000001000: next_state = 10'b0000000111;
			10'b0000001001: next_state = 10'b0000001000;
			default: next_state = 10'b0;
		endcase
	end
	
endmodule
