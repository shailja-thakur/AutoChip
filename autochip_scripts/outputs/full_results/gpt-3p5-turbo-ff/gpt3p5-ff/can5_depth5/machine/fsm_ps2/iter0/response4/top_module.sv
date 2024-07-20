module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Declare states
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;

	// Declare state register
	reg [1:0] state;

	// Declare output register
	reg done;

	// Register to store previous input
	reg [7:0] prev_input;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1; // Start in BYTE1 state
			done <= 0;
		end else begin
			prev_input <= in;
			case (state)
				BYTE1: begin
					// Check if third bit is 1
					if (in[2] == 1'b1)
						state <= BYTE2;
					else
						state <= BYTE1;
				end

				BYTE2: state <= BYTE3;

				BYTE3: state <= DONE;

				DONE: begin
					// Check if third bit is 0
					if (in[2] == 1'b0)
						state <= BYTE1;
					else
						state <= BYTE2;
				end
			endcase
		end
	end

	// Assign done signal based on current state
	assign done = (state == DONE);

endmodule
