module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting); // Flip-flop to hold the value of start_shifting

	reg [3:0] state; // State register to store the current state

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0; // Reset the state to initial state
			start_shifting <= 0; // Reset start_shifting
		end else begin
			case (state)
				0: begin // Initial state
					if (data) begin
						state <= 1; // Transition to state 1 if input data = 1
					end
				end
				1: begin // State 1
					if (data) begin
						state <= 2; // Transition to state 2 if input data = 1
					end else begin
						state <= 0; // Transition back to initial state if input data = 0
					end
				end
				2: begin // State 2
					if (data) begin
						state <= 3; // Transition to state 3 if input data = 1
					end else begin
						state <= 0; // Transition back to initial state if input data = 0
					end
				end
				3: begin // State 3
					if (~data) begin
						state <= 0; // Transition back to initial state if input data = 0
					end else begin
						state <= 4; // Transition to state 4 if input data = 1
						start_shifting <= 1; // Set start_shifting to 1
					end
				end
				4: begin // State 4 (Final state)
					if (~data) begin
						state <= 3; // Transition back to state 3 if input data = 0
					end
				end
			endcase
		end
	end
endmodule
