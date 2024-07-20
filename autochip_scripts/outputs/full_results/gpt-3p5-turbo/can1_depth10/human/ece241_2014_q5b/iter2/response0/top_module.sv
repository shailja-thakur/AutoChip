module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Declare states
	reg [1:0] current_state, next_state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Output logic
	always @(current_state, x) begin
		case (current_state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
			end
		endcase
		
		case (current_state)
			A: z <= 1'b0;
			B: z <= 1'b1;
		endcase
	end
endmodule
