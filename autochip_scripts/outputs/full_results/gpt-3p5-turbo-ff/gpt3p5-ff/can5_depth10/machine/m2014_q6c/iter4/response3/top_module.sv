module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	wire y1;
	wire [3:0] y4_bits;
	
	assign y1 = y[1] & ~w;
	assign y4_bits = {y[5], y[3], y[2], y[6]};
	assign Y2 = y1;
	assign Y4 = y4_bits & w;
endmodule
