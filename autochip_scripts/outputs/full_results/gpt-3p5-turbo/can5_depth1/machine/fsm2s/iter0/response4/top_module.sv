module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Declare state register and next state signal
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Define state values
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	// Assign initial state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Determine next state based on current state and inputs j and k
	always @ (state, j, k) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;
		endcase
	end
	
	// Assign output based on current state
	always @ (state) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end
endmodule
