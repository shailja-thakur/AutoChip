module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		S_A = 3'd0,
		S_B = 3'd1,
		S_C = 3'd2,
		S_D = 3'd3,
		S_E = 3'd4,
		S_F = 3'd5
	} state_t;

	state_t state, next_state;

	// State flip-flops
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_A;
		end else begin
			state <= next_state;
		end
	}

	// State table
	always_comb begin
		next_state = state; // Default to stay in the same state
		case (state)
			S_A: if (w) next_state = S_B; else next_state = S_A;
			S_B: if (w) next_state = S_C; else next_state = S_D;
			S_C: if (w) next_state = S_E; else next_state = S_D;
			S_D: if (w) next_state = S_F; else next_state = S_A;
			S_E: if (w) next_state = S_E; else next_state = S_D;
			S_F: if (w) next_state = S_C; else next_state = S_D;
			default: next_state = S_A; // Default to initial state A in case of invalid state
		endcase
	}

	// Output logic
	always_comb begin
		case (state)
			S_A: z = 0;
			S_B: z = 0;
			S_C: z = 0;
			S_D: z = 0;
			S_E: z = 1;
			S_F: z = 1;
			default: z = 0;
		endcase
	}

endmodule
