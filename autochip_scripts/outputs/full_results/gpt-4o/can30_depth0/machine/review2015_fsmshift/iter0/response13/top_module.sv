module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// State encoding
	parameter B0 = 3'd0;
	parameter B1 = 3'd1;
	parameter B2 = 3'd2;
	parameter B3 = 3'd3;
	parameter Done = 3'd4;

	reg [2:0] state, next_state;

	// State transition
	always @(*) begin
		case (state)
			B0: next_state = B1;
			B1: next_state = B2;
			B2: next_state = B3;
			B3: next_state = Done;
			default: next_state = Done; // Handles other states including Done
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B0;
		else
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		if (state == B0 || state == B1 || state == B2 || state == B3)
			shift_ena = 1;
		else
			shift_ena = 0;
	end
endmodule
