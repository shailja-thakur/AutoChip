module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State Enum
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_t;

	// State, Next State
	reg state_t state, next_state;

	// State Transition Logic
	always @(posedge clk) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output Logic
	always @(state or w) begin
		case (state)
			A: begin
				if (w == 1'b0)
					next_state = B;
				else
					next_state = A;
			end

			B: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end

			C: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end

			D: begin
				if (w == 1'b1)
					next_state = A;
				else
					next_state = F;
			end

			E: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end

			F: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end
		endcase
	end

	// Output z
	always @(state) begin
		if (state == E || state == F)
			z = 1'b1;
		else
			z = 1'b0;
	end

endmodule
