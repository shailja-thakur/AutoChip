module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] count [3:0];
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (ena[1])
				count[1] <= count[1] + 1;
				
			if (ena[2])
				count[2] <= count[2] + 1;
				
			if (ena[3])
				count[3] <= count[3] + 1;
				
			count[0] <= count[0] + 1;
			
			q[3:0] = count[0];
			q[7:4] = count[1];
			q[11:8] = count[2];
			q[15:12] = count[3];
		end
	end
	
endmodule
