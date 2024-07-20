module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	reg [1:0] state, next_state;
	
	always @* begin
		// Determine next state based on current state and control signals
		case(state)
			0: next_state = (j == 1'b1) ? 1'b1 : 1'b0; // If current state is A, next state is determined by j
			1: next_state = (k == 1'b1) ? 1'b0 : 1'b1; // If current state is B, next state is determined by k
		endcase
	end

	always @(posedge clk) begin
		// Update state based on reset and next state
		if (areset == 1'b1)
			state <= 2'b0; // Reset state to A
		else
			state <= next_state; // Update state to next state
	end

	assign out = (state == 1'b1) ? 1'b1 : 1'b0; // Output high if current state is B, otherwise output low

endmodule
