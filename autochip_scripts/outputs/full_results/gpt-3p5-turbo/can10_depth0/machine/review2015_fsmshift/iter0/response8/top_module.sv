module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= B0;
		else
			state <= next_state;
	end

	always @(*)
	begin
		case (state)
			B0: next_state = B1;
			B1: next_state = B2;
			B2: next_state = B3;
			B3: next_state = Done;
			default: next_state = Done;
		end
	end

	assign shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);

endmodule
