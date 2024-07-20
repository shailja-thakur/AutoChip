module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	always @(posedge clk)
	begin
		// Reset the register to 0 when resetn is low
		if (!resetn)
			q <= 16'b0;
		else
		begin
			// Write data to register based on byte enable signal
			if (byteena[0])
				q[7:0] <= d[7:0];
				
			if (byteena[1])
				q[15:8] <= d[15:8];
		end
	end
endmodule
