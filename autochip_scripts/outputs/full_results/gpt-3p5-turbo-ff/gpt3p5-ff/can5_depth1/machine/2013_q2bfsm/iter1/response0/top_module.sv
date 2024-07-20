module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State definition
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} states;

	// Register to hold the current state
	reg [3:0] current_state, next_state;

	// State transition logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(current_state or x) begin
		case (current_state)
			A: next_state = B;
			B: next_state = S0;
			S0: next_state = (x == 1) ? S1 : S0;
			S1: next_state = (x == 1) ? S1 : S10;
			S10: next_state = (x == 1) ? G1 : S0;
			G1: next_state = (y == 1) ? P1 : G2;
			G2: next_state = (y == 1) ? P1 : P0;
			P0: next_state = P0;
			P1: next_state = P1;
			default: next_state = A;
		endcase
	end

	// Output assignments
	always @(current_state, resetn) begin
		if (!resetn)
			f <= 1'b0;
		else if (current_state == B)
			f <= 1'b1;
		else
			f <= 1'b0;

		if (!resetn)
			g <= 1'b0;
		else if (current_state == G1 || current_state == G2 || current_state == P1)
			g <= 1'b1;
		else
			g <= 1'b0;
	end

endmodule
