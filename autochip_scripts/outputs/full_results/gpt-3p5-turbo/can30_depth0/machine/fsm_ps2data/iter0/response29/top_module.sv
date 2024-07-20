module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Internal state definition
	enum { BYTE1, BYTE2, BYTE3, DONE } state;
	reg [2:0] next_state;

	// Registers to store the shift register and the current input
	reg [23:0] shift_register;
	reg [7:0] current_input;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			next_state <= BYTE1;
			done <= 0;
			out_bytes <= 0;
		end else begin
			// Determine the next state based on the current state and input
			case(state)
				BYTE1: if (in[2] == 1) next_state <= BYTE2;
						else next_state <= BYTE1;
				BYTE2: if (in[2] == 1) next_state <= BYTE3;
						else next_state <= BYTE1;
				BYTE3: next_state <= DONE;
				DONE: if (in[2] == 0) next_state <= BYTE1;
						else next_state <= DONE;
				default: next_state <= BYTE1;
			endcase

			// Update the current state
			state <= next_state;

			// Update the shift register and current input
			shift_register <= {shift_register[15:0], in};
			current_input <= in;

			// Update out_bytes if done signal is set to 1
			if (state == DONE) out_bytes <= shift_register;

			done <= (state == DONE);
		end
	end
endmodule
