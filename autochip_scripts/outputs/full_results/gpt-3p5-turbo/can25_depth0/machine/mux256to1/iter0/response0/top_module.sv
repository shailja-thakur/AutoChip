module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	/* Check if sel is out of range */
	wire [7:0] valid_sel;
	assign valid_sel = (sel > 255) ? 0 : sel;

	/* Output bit */
	assign out = in[valid_sel];

endmodule
