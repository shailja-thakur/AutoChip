module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

wire y1;
wire y2;
wire y3;
wire y4;

assign y1 = y[1];
assign y2 = y[2];
assign y3 = y[3];
assign y4 = y[5];
assign y5 = y[6];

assign Y2 = y1 & (~w);
assign Y4 = y2 & y3 & y4 & y5 & w;
endmodule
