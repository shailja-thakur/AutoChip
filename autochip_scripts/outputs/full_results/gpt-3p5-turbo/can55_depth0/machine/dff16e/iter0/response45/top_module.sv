module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	always@(posedge clk)
	begin
		if(!resetn)
			q <= 16'b0;  // Reset the register to 0 when resetn is low
		else begin
			if(byteena[0])  // If the first bit of byteena is high
				q[7:0] <= d[7:0];  // Write lower 8 bits of d to lower 8 bits of q
			
			if(byteena[1])  // If the second bit of byteena is high
				q[15:8] <= d[15:8];  // Write upper 8 bits of d to upper 8 bits of q
		end
	end
	
endmodule
