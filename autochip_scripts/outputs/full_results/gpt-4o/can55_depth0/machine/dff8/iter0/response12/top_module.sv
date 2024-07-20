module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initial block to set output to default value
	initial begin
		q = 8'h00;
	end

	// Always block to store the input data on rising edge of the clock
	always @(posedge clk) begin
		q <= d;
	end

endmodule
