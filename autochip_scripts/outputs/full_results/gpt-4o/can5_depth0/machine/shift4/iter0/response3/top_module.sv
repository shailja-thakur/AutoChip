module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset)
			q <= 4'b0000; // Asynchronous reset sets q to 0
		else if (load)
			q <= data; // Load signal loads data into q
		else if (ena)
			q <= {q[2:0], 1'b0}; // Enable signal shifts q left by 1 bit
	end
endmodule
