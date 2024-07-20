module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [1:0] state, next_state;
	
	// Define states A and B
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	// Define initial state
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Define next state logic
	always @ (*) begin
		case (state)
			A: begin
				if (x == 1'b0)
					next_state = A;
				else
					next_state = B;
			end
			
			B: begin
				if (x == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
		endcase
	end
	
	// Define output logic
	always @ (*) begin
		case (state)
			A: z = 1'b0;
			B: z = 1'b1;
		endcase
	end
endmodule
