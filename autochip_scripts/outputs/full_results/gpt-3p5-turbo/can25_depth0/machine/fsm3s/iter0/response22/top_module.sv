module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states as parameters
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define the current state and next state variables
	reg [1:0] state, next_state;
	
	// Initialize the current state to A
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Assign the next state based on the current state and input
	always @* begin
		case(state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end
	
	// Assign the output based on the current state
	always @* begin
		out = (state == D);
	end

endmodule
