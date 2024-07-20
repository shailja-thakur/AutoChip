module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

wire Y1_wire;
wire Y3_wire;

assign Y1_wire = y[0] & w;
assign Y3_wire = (y[1] | y[2] | y[4] | y[5]) & (~w);

assign Y1 = Y1_wire;
assign Y3 = Y3_wire;

endmodule
