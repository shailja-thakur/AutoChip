module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	parameter A = 0;
	parameter B = 1;
	
	// Define the state and next state signals
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Update the state on the rising edge of clock and reset to state B on the rising edge of areset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	// Determine the next state based on the current state and input signals
	always @(state, in) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				end
			
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				end
		endcase
	end
	
	// Output is high when the state is B and low otherwise
	assign out = (state == B);
	
endmodule
