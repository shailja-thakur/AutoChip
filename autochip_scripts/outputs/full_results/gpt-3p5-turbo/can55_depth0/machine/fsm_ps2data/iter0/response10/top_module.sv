module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

// State definition
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// State register
reg [1:0] state;

// Register for shifting input
reg [23:0] shift_register;

always @(posedge clk) begin
	// Reset if specified
	if (reset)
		state <= BYTE1; // Go to initial state

	// State machine logic
	else begin
		case (state)
			BYTE1:
				if (in[2])
					state <= BYTE2;
				else
					state <= BYTE1;

			BYTE2:
				if (in[2])
					state <= BYTE3;
				else
					state <= BYTE1;

			BYTE3:
				if (in[2])
					state <= DONE;
				else
					state <= BYTE1;

			DONE:
				if (reset)
					state <= BYTE1;
				else
					state <= DONE;
		endcase
	end

	// Update output register on DONE state
	if (state == DONE)
		out_bytes <= shift_register;
	
	// Shift input into register
	shift_register <= {shift_register[15:0], in};

	// Set done signal
	done <= (state == DONE);
end

endmodule
