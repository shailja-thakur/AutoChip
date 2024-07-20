module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] q_ones;
	reg [3:0] q_tens;
	
	always @(posedge clk or posedge reset) begin
		if(reset)
			begin
				q <= 0;
				q_ones <= 0;
				q_tens <= 0;
			end
		else if(ena[3])
			begin
				if(q_ones == 9)
					q_ones <= 0;
				else
					q_ones <= q_ones + 1;
			end
		
		if(ena[2])
			begin
				if(q_tens == 9)
					q_tens <= 0;
				else
					q_tens <= q_tens + 1;
			end
	end
	
	assign q = {q_ones, q_tens};
	assign ena[1] = 1;
	
endmodule
