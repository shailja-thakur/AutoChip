module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] in_delayed;

	always @(posedge clk) begin
		in_delayed <= in;  // Capture the input on each clock cycle
		pedge <= (~in_delayed & in);  // Detect positive edge: 0 to 1 transition
	end

endmodule
