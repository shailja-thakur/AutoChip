module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State declaration
	typedef enum logic [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (current_state)
			A: if (w) next_state = A; else next_state = B;
			B: if (w) next_state = D; else next_state = C;
			C: if (w) next_state = D; else next_state = E;
			D: if (w) next_state = A; else next_state = F;
			E: if (w) next_state = D; else next_state = E;
			F: if (w) next_state = D; else next_state = C;
			default: next_state = A;
		endcase
	end

	// Output logic
	always_comb begin
		case (current_state)
			E, F: z = 1;
			default: z = 0;
		endcase
	end

endmodule
