module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'd0, // Initial state
		S1 = 2'd1  // Complements bits
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		next_state = state;
		case (state)
			S0: begin
				if (!areset) begin
					next_state = S1;
				end
			end
			S1: begin
				if (areset) begin
					next_state = S0;
				end
			end
		endcase
	end

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end else begin
			case (state)
				S0: begin
					z <= x; // Directly output x until the first 1 is received
				end
				S1: begin
					z <= ~x; // Output complement of x after first 1
				end
			endcase
		end
	end

endmodule
