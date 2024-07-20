module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q
);

always @(posedge clk) begin
	if (load) begin
		q <= data;  // Load data into q when load is high
	end else if (ena == 2'h1) begin
		q <= q << 1;  // Shift left when ena is 2'h1
	end else if (ena == 2'h2) begin
		q <= q >> 1;  // Shift right when ena is 2'h2
	end
end

endmodule
