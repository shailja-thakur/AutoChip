module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B; // for safety
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			A: out = 0;
			B: out = 1;
			default: out = 1;
		endcase
	end

endmodule
