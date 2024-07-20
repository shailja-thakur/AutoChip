module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			A: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
	
endmodule
