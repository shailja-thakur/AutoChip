module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state; // Represents the current state of the FSM

	// Define the state encoding
	parameter S0 = 2'b00; // Initial state
	parameter S1 = 2'b01; // Searching for '1'
	parameter S2 = 2'b10; // Searching for '1' after finding '1'
	parameter S3 = 2'b11; // Searching for '10' after finding '11'
	parameter S4 = 2'b100; // Searching for '110' after finding '110

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0; // Reset to initial state
			start_shifting <= 0; // Reset the shifting flag
		end else begin
			case (state)
				S0: begin // Initial state
					if (data) begin
						state <= S1; // Start searching for '1'
						start_shifting <= 0; // Reset the shifting flag
					end
				end
				S1: begin // Searching for '1'
					if (data) begin
						state <= S2; // Found '1', search for another '1'
						start_shifting <= 0; // Reset the shifting flag
					end
				end
				S2: begin // Searching for '1' after finding '1'
					if (data) begin
						state <= S2; // Found '1', continue searching for another '1'
						start_shifting <= 0; // Reset the shifting flag
					end else begin
						state <= S3; // Found '1' but next bit is '0', search for '10'
						start_shifting <= 0; // Reset the shifting flag
					end
				end
				S3: begin // Searching for '10' after finding '11'
					if (data) begin
						state <= S4; // Found '1', continuing search for '110'
						start_shifting <= 0; // Reset the shifting flag
					end else begin
						state <= S1; // Found '1' but next bit is not '0', restart search
						start_shifting <= 0; // Reset the shifting flag
					end
				end
				S4: begin // Searching for '110' after finding '110'
					if (data) begin
						state <= S2; // Found '1', restart search for '1'
						start_shifting <= 0; // Reset the shifting flag
					end else begin
						state <= S1; // Found '1' but next bit is not '0', restart search
						start_shifting <= 0; // Reset the shifting flag
					end
				end
			endcase
		end
	end

endmodule
