module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State Declaration
	parameter A = 1'b0, B = 1'b1;
	reg state, next_state;

	// Combinational Logic Block
	always @(*) begin
		case (state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
			default: next_state = A; // Default case to handle unexpected situations
		endcase
	end

	// Sequential Logic Block
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset to initial state B
		else
			state <= next_state; // Update state
	end

	// Output Logic
	assign out = (state == B);

endmodule
