module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Declare states
	typedef enum logic [3:0] {
		A,
		B,
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state;

	// Declare state variables
	state current_state;
	state next_state;

	// Declare signal assignments
	assign f = (current_state == B) ? 1'b1 : 1'b0;
	assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;

	// Declare state transition logic
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Declare next state logic
	always_comb begin
		case (current_state)
			A: next_state = B;
			B: next_state = S0;
			S0: next_state = (x == 1'b1) ? S1 : S0;
			S1: next_state = (x == 1'b1) ? S1 : S10;
			S10: next_state = (x == 1'b1) ? G1 : S0;
			G1: next_state = (y == 1'b1) ? P1 : G2;
			G2: next_state = (y == 1'b1) ? P1 : P0;
			P0: next_state = P0;
			P1: next_state = P1;
		endcase
	end

endmodule
