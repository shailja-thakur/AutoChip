module top_module (
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge
);

	reg [7:0] d_last;

	always @(posedge clk) begin
		// Detect any edge on the `in` signal
		anyedge <= in ^ d_last;
		// Update `d_last` with the current value of the `in` signal
		d_last <= in;
	end

endmodule
