module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);

always @(posedge clk) begin
	if (load) begin
		q <= data;
	end else begin
		q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0}; // Shift right and XOR the last two bits, then add 0 at the beginning of q
	end
end

endmodule
