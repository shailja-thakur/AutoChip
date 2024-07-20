module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	// The output q is 512 bits long and is a reg type which can store the value inside.

	always @(posedge clk) begin
		// When the clock edge comes, the following operation will be executed.

		// The operation when load is 1
		if (load)
			q <= data; // The input data will be loaded to the output q.

		// The operation when load is 0
		else begin
			q <= {q[$bits(q)-2:0], q[0]};
		end

		// The last two bits of q are xored, and a 0 is added at the beginning of q.

	end

endmodule
