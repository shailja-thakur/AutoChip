module top_module (
	input clk,
	input a,
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1)
			q <= 3'b100; // Set q to 4
		else if (a == 0 && q == 3'b110)
			q <= 3'b000; // Set q to 0 when q is 6
		else if (a == 0)
			q <= q + 1; // Increment q by 1
	end

endmodule
