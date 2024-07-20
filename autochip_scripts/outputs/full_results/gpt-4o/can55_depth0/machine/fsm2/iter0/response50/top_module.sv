module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	// States declaration
	typedef enum reg [0:0] {A, B} state_t;
	state_t state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A;
		endcase
	end

	// Sequential logic to update state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B);
	end

endmodule
