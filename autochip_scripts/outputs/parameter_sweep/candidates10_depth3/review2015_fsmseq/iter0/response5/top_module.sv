module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting); // Added 'reg' keyword for start_shifting
	
	reg [3:0] state; // Added 'reg' keyword for state
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0; // Reset state to 0
			start_shifting <= 0; // Reset start_shifting to 0
		end
		else begin
			case (state)
				0: if (data) state <= 1; // Transition to state 1 if input is high
				1: if (data) state <= 2; // Transition to state 2 if input is high
				   else state <= 0; // Transition back to state 0 if input is low
				2: if (data) state <= 3; // Transition to state 3 if input is high
				   else state <= 0; // Transition back to state 0 if input is low
				3: if (data) begin // Transition to state 4 if input is high
					   state <= 4;
					   start_shifting <= 1; // Set start_shifting to 1
				   end
				   else begin
					   state <= 0; // Transition back to state 0 if input is low
					   start_shifting <= 0; // Set start_shifting to 0
				   end
				4: if (data) state <= 4; // Stay in state 4 if input is high
				   else begin
					   state <= 0; // Transition back to state 0 if input is low
					   start_shifting <= 0; // Set start_shifting to 0
				   end
			endcase
		end
	end
	
endmodule
