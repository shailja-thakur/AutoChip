module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] in_d;

	always @(posedge clk) begin
		in_d <= in;           // Store the current input values for comparison in the next clock cycle
		pedge <= ~in_d & in;  // Detect rising edge transitions: '0' in previous cycle and '1' in current
	end

endmodule
