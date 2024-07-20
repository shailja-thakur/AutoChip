module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
            
	reg [15:0] next_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			if (ena[1])
				next_q[7:4] = q[7:4] + 1;
			else
				next_q[7:4] = q[7:4];
				
			if (ena[2])
				next_q[11:8] = q[11:8] + 1;
			else
				next_q[11:8] = q[11:8];
				
			if (ena[3])
				next_q[15:12] = q[15:12] + 1;
			else
				next_q[15:12] = q[15:12];
				
			next_q[3:0] = q[3:0] + 1;
			
			q <= next_q;
		end
	end
endmodule
