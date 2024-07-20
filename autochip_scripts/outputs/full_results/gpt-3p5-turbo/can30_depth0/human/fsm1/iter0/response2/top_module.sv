module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	parameter B = 1'b0;
	parameter A = 1'b1;
	
	// Define outputs
	reg out;
	
	// Define current state
	reg state;
	
	// Define next state
	reg next_state;
	
	// Define Moore outputs
	always @(state)
	begin
		case(state)
			B: out = 1'b0;
			A: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
	
	// Define state transitions and next state logic
	always @(posedge clk)
	begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	always @(*)
	begin
		case(state)
			B: 
				begin
					if (in)
						next_state = A;
					else
						next_state = B;
				end
			A: 
				begin
					if (in)
						next_state = A;
					else
						next_state = B;
				end
			default: next_state = B;
		endcase
	end
endmodule
