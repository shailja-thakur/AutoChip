module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initialize the output to default value of 8'h0
	initial begin
		q = 8'h0;
	end

	// Assign data input to output on rising edge of the clock
	always @(posedge clk) begin
		q <= d;
	end

endmodule
