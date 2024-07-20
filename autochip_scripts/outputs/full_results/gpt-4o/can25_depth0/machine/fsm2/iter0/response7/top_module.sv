module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;

	// Current state and next state variables
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A; // Default state
		endcase
	end

	// Sequential logic to update the current state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A; // Reset to state A
		end else begin
			state <= next_state; // Update to next state
		end
	end

	// Output logic
	always @(*) begin
		out = (state == B);
		end
	endmodule
