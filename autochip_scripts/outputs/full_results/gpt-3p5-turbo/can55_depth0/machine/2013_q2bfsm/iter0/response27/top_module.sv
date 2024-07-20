module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define states
	enum logic [3:0] states;
	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S10 = 4'b0010;
	parameter G1 = 4'b0011;
	parameter G2 = 4'b0100;
	parameter P0 = 4'b0101;
	parameter P1 = 4'b0110;
	parameter A = 4'b0111;
	parameter B = 4'b1000;

	// Define state register
	reg logic [3:0] current_state;
	reg logic [3:0] next_state;

	// Assign initial state
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Assign next state logic
	always @(current_state, x) begin
		case (current_state)
			S0: if (x) next_state <= S1; else next_state <= S0;
			S1: if (x) next_state <= S1; else next_state <= S10;
			S10: if (x) next_state <= G1; else next_state <= S0;
			G1: if (y) next_state <= P1; else next_state <= G2;
			G2: if (y) next_state <= P1; else next_state <= P0;
			P0: next_state <= P0;
			P1: next_state <= P1;
			default: next_state <= A;
		endcase
	end

	// Output assignments
	assign f = (current_state == B) ? 1'b1 : 1'b0;
	assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;

endmodule
