module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states for the finite-state machine
	parameter S_INIT = 2'b00;
	parameter S_10 = 2'b01;
	parameter S_110 = 2'b10;
	parameter S_1101 = 2'b11;
	
	reg [1:0] state;	// Current state register
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_INIT;	// Initialize state on reset
			start_shifting <= 0;	// Reset start_shifting signal
		end else begin
			case (state)
				S_INIT: begin
					if (data) begin
						state <= S_10;	// Move to the next state if data is high
					end else begin
						state <= S_INIT;	// Stay in the same state if data is low
					end
				end
				
				S_10: begin
					if (data) begin
						state <= S_110;	// Move to the next state if data is high
					end else begin
						state <= S_INIT;	// Move back to the initial state if data is low
					end
				end
				
				S_110: begin
					if (data) begin
						state <= S_1101;	// Move to the next state if data is high
					end else begin
						state <= S_INIT;	// Move back to the initial state if data is low
					end
				end
				
				S_1101: begin
					state <= S_1101;	// Stay in the same state
					start_shifting <= 1;	// Set start_shifting signal to 1
				end
			endcase
		end
	end
endmodule
