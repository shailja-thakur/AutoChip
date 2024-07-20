module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		S0,  // initial state
		S1   // complementing state
	} state_t;

	state_t state, next_state;
	reg complement;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @* begin
		next_state = state;
		case (state)
			S0: begin
				if (x)
					next_state = S1;
			end

			S1: begin
				if (areset)
					next_state = S0;
				else
					next_state = S1;
			end

		endcase
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
			complement <= 1;
		end else begin
			if (state == S0) begin
				z <= x;
			end else if (state == S1) begin
				z <= x ^ complement;
				complement <= 0;
			end
		end
	end

endmodule
