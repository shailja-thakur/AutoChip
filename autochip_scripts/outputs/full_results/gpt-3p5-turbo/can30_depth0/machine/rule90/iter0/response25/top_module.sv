module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

always @(posedge clk) begin
	// The operation when load is 1
	if (load) begin
		q <= data;
	end
	// The operation when load is 0
	else begin
		q <= q[$bits(q)-1:1] ^ {q[$bits(q)-2:0], 1'b0};
	end
	// End the operation
end

endmodule
