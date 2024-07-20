module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	parameter B = 1'b0;
	parameter A = 1'b1;
	
	reg state, next_state;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	always @(state, in)
	begin
		case (state)
			B:
			begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = B;
			end
			
			A:
			begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = A;
			end
		endcase
	end
endmodule
