module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

// Define states
parameter A = 0;  // Initial state
parameter B = 1;
parameter S0 = 2;
parameter S1 = 3;
parameter S10 = 4;
parameter G1 = 5;
parameter G2 = 6;
parameter P0 = 7;
parameter P1 = 8;

reg [2:0] state_reg, state_next;

// Output assignments
assign f = (state_reg == B);
assign g = (state_reg == G1) || (state_reg == G2) || (state_reg == P1);

// Sequential logic
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

// State transitions
always @* begin
	case (state_reg)
		A: begin
			state_next = B;
		end
		B: begin
			state_next = S0;
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
		P0: begin
			state_next = P0;
		end
		P1: begin
			state_next = P1;
		end
		default: begin
			state_next = A;
		end
	endcase
end

endmodule
