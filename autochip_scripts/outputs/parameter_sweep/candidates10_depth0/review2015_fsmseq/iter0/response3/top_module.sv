module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state, next_state;  // State registers
	parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100;

	// Asynchronous reset
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(state, data)
	begin
		case(state)
			S0: if (data) next_state = S1; else next_state = S0;
			S1: if (data) next_state = S1; else next_state = S2;
			S2: if (data) next_state = S3; else next_state = S0;
			S3: if (!data) next_state = S4; else next_state = S1;
			S4: if (data) next_state = S1; else next_state = S2;
			default: next_state = S0;
		endcase
	end

	// Output logic
	assign start_shifting = (state == S4);

endmodule
