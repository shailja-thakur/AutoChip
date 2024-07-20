module top_module (
    input clk,
    input in,
    input reset,
    output out
);

	// Define states
	parameter B = 1'b0;
	parameter A = 1'b1;
	reg state, next_state;
	
	// Define output
	reg out;
	always @(state) begin
		case (state)
			B: out = 1'b1;
			A: out = 1'b0;
			default: out = 1'bx;
		endcase
	end
	
	// Define synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end
	
	// Define next state logic
	always @(state, in) begin
		case (state)
			B: if (in)
				    next_state = B;
			   else
				    next_state = A;
			A: if (in)
				    next_state = A;
			   else
				    next_state = B;
			default: next_state = B;
		endcase
	end
	
endmodule
