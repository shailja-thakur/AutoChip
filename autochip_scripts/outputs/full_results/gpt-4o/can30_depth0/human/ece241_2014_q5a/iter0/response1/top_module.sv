module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0, // State 0 (Initial state)
		S1  // State 1 (Transition state)
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			z <= 0;
		end else begin
			state <= next_state;
			case (state)
				S0: begin
					if (x == 1) z <= 0; // Initial 1 is converted to 0
					else z <= 1; // Initial 0 is converted to 1
				end
				S1: begin
					z <= ~x; // Complement every following bit
				end
			endcase
		end
	end

	always @(*) begin
		case (state)
			S0: begin
				if (x == 1) next_state = S1;
				else next_state = S0;
			end
			S1: begin
				next_state = S1;
			end
			default: next_state = S0;
		endcase
	end

endmodule
