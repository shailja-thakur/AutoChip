module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	assign out1 = (state[7] && state[9]) ? 1'b1 :
				 (state[5] && state[9]) ? 1'b1 :
				 (state[9] && state[6]) ? 1'b0 :
				 (state[9] && !state[8]) ? 1'b1 :
				 1'b0;
	
	assign out2 = (state[9] && state[7]) ? 1'b1 :
				 1'b0;
	
	assign next_state[0] = (state[0] && !in) ? 1'b1 :
				   (state[0] && in) ? 1'b0 :
				   1'b0;
				
	assign next_state[1] = (!state[0] && !in) ? 1'b1 :
				   (state[0] && !in) ? 1'b0 :
				   (state[0] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[2] = (state[1] && !in) ? 1'b0 :
				   (state[1] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[3] = (!state[2] && in) ? 1'b0 :
				   (state[2] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[4] = (state[3] && !in) ? 1'b1 :
				   (state[3] && in) ? 1'b0 :
				   1'b0;
				
	assign next_state[5] = (state[4] && !in) ? 1'b1 :
				   (state[4] && in) ? 1'b0 :
				   1'b0;
				
	assign next_state[6] = (!state[5] && in) ? 1'b0 :
				   (state[5] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[7] = (state[6] && !in) ? 1'b1 :
				   (state[6] && in) ? 1'b1 :
				   (state[7] && !in) ? 1'b0 :
				   (state[7] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[8] = (state[8] && !in) ? 1'b1 :
				   (state[8] && in) ? 1'b0 :
				   (state[9] && !in) ? 1'b0 :
				   (state[9] && in) ? 1'b1 :
				   1'b0;
				
	assign next_state[9] = (state[9] && !in) ? 1'b1 :
				   (state[9] && in) ? 1'b0 :
				   1'b0;
  
endmodule
