module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

typedef enum logic [1:0] {
	S0, // Initial state
	S1  // Flipping state
} state_t;

state_t state, next_state;

always_ff @(posedge clk or posedge areset) begin
	if (areset)
		state <= S0;
	else
		state <= next_state;
end

always_comb begin
	case (state)
		S0: begin
			if (x == 1'b1) begin
				next_state = S1;
			end else begin
				next_state = S0;
			end
		end
		S1: begin
			next_state = S1; // Stay in flipping state
		end
	endcase
end

always_ff @(posedge clk or posedge areset) begin
	if (areset) begin
		z <= 1'b0;
	end else begin
		case (state)
			S0: z <= x; // Pass through initially
			S1: z <= ~x; // Flip bits for 2's complement
		endcase
	end
end

endmodule
