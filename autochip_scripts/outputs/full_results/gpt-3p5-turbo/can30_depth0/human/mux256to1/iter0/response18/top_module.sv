module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] selected_input;
wire select;

assign select = (sel == 0);
assign selected_input = select ? in[0] : in[sel];

assign out = selected_input;

endmodule
