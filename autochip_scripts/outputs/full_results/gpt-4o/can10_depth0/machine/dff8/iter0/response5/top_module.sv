module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initialize the output to a default value of 8'h00
	initial begin
		q = 8'h00;
	end

	// Always block triggered on the rising edge of the clock input
	always @(posedge clk) begin
		q <= d;  // Store the data input in the register and output it
	end

endmodule
