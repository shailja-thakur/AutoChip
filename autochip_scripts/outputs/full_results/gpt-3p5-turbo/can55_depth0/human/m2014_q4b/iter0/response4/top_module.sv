module d_ff (
	input clk,
	input d,
	input ar,
	output reg q
);

always @(posedge clk or posedge ar)
	if (ar)
		q <= 0;
	else
		q <= d;

endmodule
module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

d_ff ff (
	.clk(clk),
	.d(d),
	.ar(ar),
	.q(q)
);

endmodule
