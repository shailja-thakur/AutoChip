module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	parameter B = 0;
	parameter A = 1;
	
	reg state;
	reg next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end
	
	always @(state or in) begin
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
		endcase
	end
	
	always @(state) begin
		case (state)
			B: out = 1;
			A: out = 0;
		endcase
	end
endmodule
