module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;

	// Define current state and next state variables
	reg [1:0] state_reg, state_next;

	// Define output done signal
	wire done;

	// State machine logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state_reg <= BYTE1;
		else
			state_reg <= state_next;
	end

	// Next state logic
	always @*
	begin
		case(state_reg)
			BYTE1:
				if (in[2] == 1)
					state_next = BYTE2;
				else
					state_next = BYTE1;
			BYTE2:
				state_next = BYTE3;
			BYTE3:
				state_next = DONE;
			DONE:
				if (in[2] == 1)
					state_next = BYTE2;
				else
					state_next = BYTE1;
		endcase
	end

	// Output logic
	assign done = (state_reg == DONE);

endmodule
