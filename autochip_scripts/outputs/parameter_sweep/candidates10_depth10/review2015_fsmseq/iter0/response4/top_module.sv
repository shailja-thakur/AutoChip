module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	parameter S0 = 2'b00;  // State 0
	parameter S1 = 2'b01;  // State 1
	parameter S2 = 2'b10;  // State 2
	parameter S3 = 2'b11;  // State 3
	
	reg [1:0] state;  // Current state register

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;  // Reset the state to S0
			start_shifting <= 0;  // Set start_shifting to 0
		end else begin
			case(state)
				S0: begin
					if (data) begin
						state <= S1;  // Transition to State 1 if data is 1
					end
				end
				S1: begin
					if (data) begin
						state <= S1;  // Stay in State 1 if data is 1
					end else begin
						state <= S2;  // Transition to State 2 if data is 0
					end
				end
				S2: begin
					if (data) begin
						state <= S1;  // Transition to State 1 if data is 1
					end else begin
						state <= S3;  // Transition to State 3 if data is 0
					end
				end
				S3: begin
					if (data) begin
						state <= S1;  // Transition to State 1 if data is 1
						start_shifting <= 1;  // Set start_shifting to 1
					end else begin
						state <= S2;  // Transition to State 2 if data is 0
					end
				end
				default: state <= S0;
			endcase
		end
	end
	
endmodule
