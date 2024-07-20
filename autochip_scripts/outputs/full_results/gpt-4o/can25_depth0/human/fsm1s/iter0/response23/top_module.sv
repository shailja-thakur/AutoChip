module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t curr_state, next_state;

	// State transition logic
	always @(*) begin
		case (curr_state)
			B: if (in)
				next_state = B;
			   else
				next_state = A;
			A: if (in)
				next_state = A;
			   else
				next_state = B;
			default: next_state = B; // Should not happen, default to reset state
		endcase
	end

	// Output logic for Moore machine
	always @(*) begin
		case (curr_state)
			B: out = 1;
			A: out = 0;
			default: out = 1; // Should not happen, default to reset state output
		endcase
	end

	// State register logic
	always @(posedge clk) begin
		if (reset)
			curr_state <= B;
		else
			curr_state <= next_state;
	end
	
endmodule
