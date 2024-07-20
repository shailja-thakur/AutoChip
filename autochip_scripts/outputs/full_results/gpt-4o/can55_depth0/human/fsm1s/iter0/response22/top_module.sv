module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;  
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B: next_state = (in) ? B : A;
			A: next_state = (in) ? A : B;
			default: next_state = B; // should not happen  
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic (Moore FSM: output depends only on the current state)
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1; // should not happen
		endcase
	end

endmodule
