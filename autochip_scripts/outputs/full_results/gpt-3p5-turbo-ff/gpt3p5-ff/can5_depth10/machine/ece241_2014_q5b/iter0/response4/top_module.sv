module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// Parameter definition
	parameter A = 0;
	parameter B = 1;
	
	// State register
	reg [1:0] state;
	
	// Assign initial value to state register
	always @(posedge clk or negedge areset) begin
		if (~areset)
			state <= A;
		else
			state <= state;
	end
	
	// State machine behavior
	always @(posedge clk) begin
		case(state)
			A: begin
				if (x)
					state <= B;
				else
					state <= A;
			end
			
			B: begin
				state <= B;
			end
			
			default: begin
				state <= A;
			end
		endcase
	end
	
	// Output assignment
	assign z = (state == A && x) || (state == B && ~x);
	
endmodule
