module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State encoding
	typedef enum reg [2:0] {A, B, C, D, E, F} state_t;
	state_t state, next_state;

	// Output logic
	assign z = (state == E) | (state == F);

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: next_state = w ? A : B;
			B: next_state = w ? D : C;
			C: next_state = w ? D : E;
			D: next_state = w ? A : F;
			E: next_state = w ? D : E;
			F: next_state = w ? D : C;
			default: next_state = A;  // Default to state A for undefined states
		endcase
	end

	// State flip-flops (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;  // Reset to state A
		end else begin
			state <= next_state;
		end
	end

endmodule
