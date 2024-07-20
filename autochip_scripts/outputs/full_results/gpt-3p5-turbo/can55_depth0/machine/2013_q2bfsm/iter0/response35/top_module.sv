module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [3:0] state_reg, state_next;
parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state_reg <= A;
	else
		state_reg <= state_next;
end

always @* begin
	state_next = state_reg;
	
	case (state_reg)
		A: begin
			if (x)
				state_next = B;
			else
				state_next = S0;
		end
		B: begin
			if (x)
				state_next = S0;
			else
				state_next = A;
		end
		S0: begin
			if (x)
				state_next = S1;
			else
				state_next = S0;
		end
		S1: begin
			if (x)
				state_next = S1;
			else
				state_next = S10;
		end
		S10: begin
			if (x)
				state_next = G1;
			else
				state_next = S0;
		end
		G1: begin
			if (y)
				state_next = P1;
			else
				state_next = G2;
		end
		G2: begin
			if (y)
				state_next = P1;
			else
				state_next = P0;
		end
		P0, P1: begin
			// Stay in the same state
			state_next = state_reg;
		end
	endcase
end

assign f = (state_reg == B);
assign g = (state_reg == G1 || state_reg == G2 || state_reg == P1);

endmodule
