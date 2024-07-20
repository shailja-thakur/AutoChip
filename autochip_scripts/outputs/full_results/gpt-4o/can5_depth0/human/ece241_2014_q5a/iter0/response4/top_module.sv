module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Enumeration
	typedef enum reg [1:0] {
		S0,  // Initial state, output same as input
		S1   // State after detecting first 1, start complementing
	} state_t;

	state_t state, next_state;

	// State Transition Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next State Logic
	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				next_state = S1;
			end
			default: next_state = S0;
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			S0: z = x;
			S1: z = ~x;
			default: z = x;
		endcase
	end

endmodule
