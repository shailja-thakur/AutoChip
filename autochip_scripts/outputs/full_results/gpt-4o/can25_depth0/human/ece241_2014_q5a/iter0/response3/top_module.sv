module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0 = 2'b00, // State: No previous bit to flip yet
		S1 = 2'b01  // State: Flip the bits following a '1'
	} state_t;

	reg state, next_state;

	// State memory
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
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

	// Output logic
	always @(*) begin
		case (state)
			S0: z = ~x; // Output inverted input
			S1: z = x;  // Output the same input (no change)
			default: z = 1'b0;
		endcase
	end

endmodule
