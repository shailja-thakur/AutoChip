module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define states
	typedef enum logic [3:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_type;
	
	reg state_reg, next_state;
	
	// Assign next_state based on current state and input signals
	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= next_state;
	end
	
	// Logic for next_state transitions
	always_comb begin
		case (state_reg)
			A: if (s) next_state = B;
			B: if (w) next_state = S11; else next_state = S10;
			C: if (w) next_state = S11; else next_state = S10;
			S10: if (w) next_state = S21; else next_state = S20;
			S11: if (w) next_state = S22; else next_state = S21;
			S20: next_state = B;
			S21: if (w) next_state = C; else next_state = B;
			S22: if (w) next_state = B; else next_state = C;
		endcase
	end
	
	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 0;
		else begin
			case (state_reg)
				A: z <= 0;
				B: z <= 0;
				C: z <= 0;
				S10: z <= 0;
				S11: z <= 0;
				S20: z <= 0;
				S21: z <= 1;
				S22: z <= 1;
			endcase
		end
	end
	
endmodule
