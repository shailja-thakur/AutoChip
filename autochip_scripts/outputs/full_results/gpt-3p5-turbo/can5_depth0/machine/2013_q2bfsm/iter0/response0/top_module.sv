module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// state enumeration
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;

	// state registers
	logic [3:0] current_state;
	logic [3:0] next_state;

	// assign next state based on current state and inputs
	always_comb begin
		case (current_state)
			A: next_state = B;
			B: next_state = S0;
			S0: next_state = (x == 1) ? S1 : S0;
			S1: next_state = (x == 1) ? S1 : S10;
			S10: next_state = (x == 1) ? G1 : S0;
			G1: next_state = (y == 1) ? P1 : G2;
			G2: next_state = (y == 1) ? P1 : P0;
			P0, P1: next_state = current_state;
			default: next_state = current_state;
		endcase
	end

	// state register update on positive edge of clk
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end
	end

	// output assignments
	assign f = (current_state == B) ? 1 : 0;
	assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1 : 0;

endmodule
