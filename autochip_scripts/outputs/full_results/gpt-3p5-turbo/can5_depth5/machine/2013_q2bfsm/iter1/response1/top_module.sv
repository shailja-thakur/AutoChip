module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [3:0] state, next_state;

	always_comb begin
		case (state)
			A: next_state = B;
			B: next_state = S0;
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S10;
			S10: if (x) next_state = G1; else next_state = S0;
			G1: if (y) next_state = P1; else next_state = G2;
			G2: if (y) next_state = P1; else next_state = P0;
			P0: next_state = P0;
			P1: next_state = P1;
		endcase
	end

	always @(posedge clk, negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(state) begin
		case (state)
			B: f = 1;
			default: f = 0;
		endcase
	end

	always @(state) begin
		case (state)
			G1, G2, P1: g = 1;
			default: g = 0;
		endcase
	end

endmodule
