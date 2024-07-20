module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last; // Register to store the previous value of in

	always @(posedge clk) begin
		d_last <= in; // Update d_last with the current value of in
		anyedge <= in ^ d_last; // Detect any edge and update anyedge output
	end

endmodule
