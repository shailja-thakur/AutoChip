module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// States
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
			B: next_state = (in == 0) ? A : B;
			A: next_state = (in == 0) ? B : A;
			default: next_state = B;
		endcase
	end

	// State Register (with synchronous reset)
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output Logic
	always @(state) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase
	end

endmodule
