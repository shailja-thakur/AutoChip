module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state, next_state; // create state and next_state registers
	
	// create state variables for each state
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	
	// assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// logic to determine next state based on current state and input
	always @(*) begin
		case (state)
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
	
	// assign output based on current state
	assign out = (state == D) ? 1'b1 : 1'b0;
	
endmodule
