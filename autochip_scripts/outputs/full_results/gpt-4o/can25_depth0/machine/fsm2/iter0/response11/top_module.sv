module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define states using localparam
	localparam A = 1'b0;
	localparam B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational block to determine next state
	always @(*) begin
		case(state)
			A: if (j) next_state = B; else next_state = A;
			B: if (k) next_state = A; else next_state = B;
			default: next_state = A; // Default state to handle potential unknown states
		endcase
	end

	// Sequential block to update state on the clock edge or reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset to state A
		else
			state <= next_state;
	end

	// Output logic based on current state
	always @(state) begin
		case(state)
			A: out = 1'b0;
			B: out = 1'b1;
		endcase
	end
endmodule
