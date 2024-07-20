module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum logic [0:0] {
		A = 1'b0,
		B = 1'b1
	} state_t;

	// State registers
	state_t current_state, next_state;

	// Combinational logic for state transition
	always @(*) begin
		case (current_state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A; // Default case to handle undefined states
		endcase
	end

	// Sequential logic for state update
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (current_state == B) ? 1'b1 : 1'b0;
		end

endmodule
