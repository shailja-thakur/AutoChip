module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;
	
	// Registers for the current state and next state
	reg state_t current_state, next_state;
	
	// Reset state assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// State transition logic
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			
			C: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			
			D: begin
				if (w)
					next_state = C;
				else
					next_state = A;
			end
			
			default: next_state = A;
		endcase
	end
	
	// Output assignment
	always @(current_state) begin
		if (current_state == C)
			z = 1;
		else
			z = 0;
	end
endmodule
