module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 1'b1;
	parameter B = 1'b0;

	reg current_state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @* begin
		case (current_state)
            A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				z = 1'b0;
			end
			
			B: begin
				if (x)
					next_state = A;
				else
					next_state = B;
				z = 1'b1;
			end
		endcase
	end
endmodule
