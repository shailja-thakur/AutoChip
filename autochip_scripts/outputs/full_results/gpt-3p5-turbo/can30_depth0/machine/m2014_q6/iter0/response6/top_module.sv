module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define the states
	typedef enum logic [2:0] {
		A,
		B,
		C,
		D,
		E,
		F
	} state_t;

	reg state_reg, next_state_reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= next_state_reg;
	end

	// Transition logic
	always @(state_reg or w) begin
		case (state_reg)
			A: begin
				if (w == 1'b0)
					next_state_reg = B;
				else
					next_state_reg = A;
			end
			B: begin
				if (w == 1'b1)
					next_state_reg = D;
				else
					next_state_reg = C;
			end
			C: begin
				if (w == 1'b1)
					next_state_reg = D;
				else
					next_state_reg = E;
			end
			D: begin
				if (w == 1'b1)
					next_state_reg = A;
				else
					next_state_reg = F;
			end
			E: begin
				if (w == 1'b1)
					next_state_reg = D;
				else
					next_state_reg = E;
			end
			F: begin
				if (w == 1'b1)
					next_state_reg = D;
				else
					next_state_reg = C;
			end
			default: next_state_reg = A;
		endcase
	end

	// Output assignment
	always @(state_reg) begin
		if (state_reg == E || state_reg == F)
			z = 1'b1;
		else
			z = 1'b0;
	end

endmodule
