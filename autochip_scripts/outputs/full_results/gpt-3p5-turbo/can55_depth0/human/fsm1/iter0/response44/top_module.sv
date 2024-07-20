module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	parameter B = 0;
	parameter A = 1;
	
	reg state;
	reg next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			default:
				next_state = B;
		endcase
	end
	
	assign out = state;
	
endmodule
