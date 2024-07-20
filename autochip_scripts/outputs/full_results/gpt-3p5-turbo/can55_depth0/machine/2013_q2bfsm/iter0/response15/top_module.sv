module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define states
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
	} state_type;

	reg state_reg;
	reg next_state_reg;

	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn)
			state_reg <= A;
		else
			state_reg <= next_state_reg;
	end

	always_comb begin
		next_state_reg = state_reg;
		case (state_reg)
			A: begin
				if (x)
					next_state_reg = B;
				else
					next_state_reg = S0;
			end
			B: begin
				next_state_reg = S0;
			end
			S0: begin
				if (x)
					next_state_reg = S1;
				else
					next_state_reg = S0;
			end
			S1: begin
				if (x)
					next_state_reg = S1;
				else
					next_state_reg = S10;
			end
			S10: begin
				if (x)
					next_state_reg = G1;
				else
					next_state_reg = S0;
			end
			G1: begin
				if (y)
					next_state_reg = P1;
				else
					next_state_reg = G2;
			end
			G2: begin
				if (y)
					next_state_reg = P1;
				else
					next_state_reg = P0;
			end
			P0: begin
				next_state_reg = P0;
			end
			P1: begin
				next_state_reg = P1;
			end
		endcase
	end

	assign f = (state_reg == B) ? 1'b1 : 1'b0;
	assign g = (state_reg == G1 || state_reg == G2 || state_reg == P1) ? 1'b1 : 1'b0;

endmodule
