module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		// The operation when load is 1
		if (load)
			q <= data;
		// The operation when load is 0
		else begin
			q <= {q[$bits(q)-2:0], 1'b0} ^ q[$bits(q)-1];
		end
	end

endmodule
