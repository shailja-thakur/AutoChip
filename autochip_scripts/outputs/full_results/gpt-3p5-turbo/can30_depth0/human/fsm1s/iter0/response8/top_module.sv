module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	// Define the two states
	parameter B = 1'b0;
	parameter A = 1'b1;

	reg state, next_state;
	wire out;
	
	// Sequential logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end
		
	// Combinational logic
	always @*
	begin
		case (state)
			B: 
			begin
				// State B transition conditions
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1'b1;
			end
			A: 
			begin
				// State A transition conditions
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 1'b0;
			end
		endcase
	end
endmodule
