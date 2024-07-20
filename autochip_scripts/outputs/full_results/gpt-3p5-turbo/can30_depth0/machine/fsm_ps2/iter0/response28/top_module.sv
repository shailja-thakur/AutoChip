module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Declare internal signals for state machine
	reg [1:0] state;
	reg done_reg; // Register to hold the done signal

	// State definitions
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;

	// Implement the state machine logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1:
					if (in[2] == 1'b1)
						state <= BYTE2;
					else
						state <= BYTE1;

				BYTE2:
					state <= BYTE3;

				BYTE3:
					state <= DONE;

				DONE:
					if (in[2] == 1'b1)
						state <= BYTE2;
					else
						state <= BYTE1;
			endcase
		end

		// Update the done register
		done_reg <= (state == DONE);
	end

	// Assign the done signal
	assign done = done_reg;

endmodule
