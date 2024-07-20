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
	
	reg [1:0] curr_state, next_state; // Registers to hold current and next state values
	
	// Initialize flip-flop with reset state A
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	// State transitions and output assignment logic
	always_comb begin
		case (curr_state)
			A: begin
				if (s == 0)
					next_state = A;
				else
					next_state = B;
			end
			
			B: begin
				if (w == 1) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			
			C: begin
				if (w == 1) begin
					next_state = C;
				end else begin
					if (z == 1)
						next_state = D;
					else
						next_state = B;
				end
			end
			
			D: begin
				if (w == 1) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			end
		endcase
		
		// Output assignment
		if (curr_state == C && w == 1)
			z <= 1;
		else
			z <= 0;
	end
endmodule
