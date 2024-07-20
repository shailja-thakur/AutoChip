module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define the states
	localparam A = 1'b0;
	localparam B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			A: if (in) next_state = A; else next_state = B;
			B: if (in) next_state = B; else next_state = A;
			default: next_state = B; // Default to state B
		endcase
	end
	
	// State updating logic
	always @(posedge clk or posedge areset) begin
		if (areset) state <= B; // Reset to state B
		else state <= next_state;
	end
	
	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) out <= 1'b1; // Reset output to be consistent with state B
		else out <= (state == B);
	end
endmodule
