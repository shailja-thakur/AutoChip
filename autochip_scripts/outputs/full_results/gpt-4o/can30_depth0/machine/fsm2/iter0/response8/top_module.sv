module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State declaration
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Combinational block to determine next state
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A;  // Default state to handle unknown state conditions
		endcase
	end

	// Clocked block to update state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;  // Reset state to A
		end else begin
			state <= next_state;
		end
	end

	// Output logic based on the current state
	always @(*) begin
		out = (state == B);  // out is 1 if current state is B, otherwise 0
		end
endmodule
