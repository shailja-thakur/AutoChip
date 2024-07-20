module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg [1:0] state; // Define a 2-bit register to hold the state

	always @(posedge clk) begin // Use a positive edge-triggered clock for synchronous behavior
		if (reset) begin // Check if reset is high
			state <= 2'b00; // Set state to A when reset is high
		end else begin
			case (state) // Use a case statement to determine next state
				2'b00: begin // When current state is A
					if (j) begin // Check if j is high
						state <= 2'b01; // Set next state to B if j is high
					end
				end
				2'b01: begin // When current state is B
					if (k) begin // Check if k is high
						state <= 2'b00; // Set next state to A if k is high
					end
				end
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set output high when state is B, low otherwise

endmodule
