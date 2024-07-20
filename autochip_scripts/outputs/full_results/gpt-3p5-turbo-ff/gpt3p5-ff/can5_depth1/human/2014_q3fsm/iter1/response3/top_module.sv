module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} states;
	
	reg curr_state, next_state; // Registers to hold current and next state values
	
	initial begin
		curr_state = A;
		z = 0;
	end
	
	// State transitions and output assignment logic
	always @(posedge clk) begin
		if (reset)
			curr_state <= A;
		else
			curr_state <= next_state;
		case (curr_state)
			A: begin
				if (s == 0)
					next_state = A;
				else
					next_state = B;
			end
			
			B: begin
				if (w == 1) 
					next_state = C;
				else 
					next_state = D;
			end
			
			C: begin
				if (w == 1) 
					next_state = C;
				else if (z == 1)
						next_state = D;
					else 
						next_state = B;
			end
			
			D: begin
				if (w == 1) 
					next_state = C;
				else 
					next_state = B;
			end
		endcase
	end
	
	// Output assignment
	always @(curr_state, w) begin
		if (curr_state == C && w == 1)
			z <= 1;
		else
			z <= 0;
	end
endmodule
