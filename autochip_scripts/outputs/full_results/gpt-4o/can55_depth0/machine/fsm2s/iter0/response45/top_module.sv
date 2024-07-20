module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Define state parameters
	parameter A = 1'b0, B = 1'b1;
	
	// State registers
	reg state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
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
			
			default: next_state = A;  // Default state
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
