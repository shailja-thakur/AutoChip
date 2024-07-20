module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Default value for output
	initial begin
		q = 8'b0;
	end

	// Rising edge triggered always block
	always @(posedge clk) begin
		q <= d;
	end

endmodule
