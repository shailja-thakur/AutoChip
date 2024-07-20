module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
always @ (posedge clk)
	d <= in ^ out;

always @ (posedge clk)
	out <= d;

endmodule
