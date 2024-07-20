module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state parameters
	parameter STATE_A = 1'b0;
	parameter STATE_B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
		
			STATE_B: begin
				if (in)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
		
			default: next_state = STATE_A;  // Default state
		endcase
	end
	
	// Sequential logic block to update state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= STATE_B;  // Reset to initial state B
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		if (state == STATE_B)
			out = 1'b1;
		else
			out = 1'b0;
		end
endmodule
