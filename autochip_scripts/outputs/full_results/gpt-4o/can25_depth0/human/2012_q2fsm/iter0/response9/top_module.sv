module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;

	state_t state, next_state;

	// State Flip-Flops
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next State Logic
	always_comb begin
		case (state)
			A: 
				if (w)
					next_state = B;
				else
					next_state = A;
			B:
				if (w)
					next_state = C;
				else
					next_state = D;
			C:
				if (w)
					next_state = E;
				else
					next_state = D;
			D:
				if (w)
					next_state = F;
				else
					next_state = A;
			E:
				if (w)
					next_state = E;
				else
					next_state = D;
			F:
				if (w)
					next_state = C;
				else
					next_state = D;
			default: next_state = A;
		endcase
	end

	// Output Logic
	always_comb begin
		case (state)
			A, B, C, D: z = 0;
			E, F:       z = 1;
			default:    z = 0;
		endcase
	end

endmodule
