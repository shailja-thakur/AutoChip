module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output [15:0] q);   // changed "reg" to "[15:0]"
	
	always @(posedge clk) begin
		if (~resetn) begin 
			q <= 16'b0;   // reset the register to 0
		end else begin
			if (byteena[0]) begin
				q[7:0] <= d[7:0];   // write lower 8 bits of d to lower 8 bits of q if byteena[0] is high
			end
			if (byteena[1]) begin
				q[15:8] <= d[15:8];   // write upper 8 bits of d to upper 8 bits of q if byteena[1] is high
			end
		end
	end
	
endmodule
