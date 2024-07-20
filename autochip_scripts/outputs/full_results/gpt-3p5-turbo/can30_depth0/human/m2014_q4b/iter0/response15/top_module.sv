module d_flip_flop (
	input clk,
	input d,
	input ar,
	output logic q
);
	always_ff @(posedge clk or posedge ar) begin
		if (ar)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule
module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	d_flip_flop flip_flop(
		.clk(clk),
		.d(d),
		.ar(ar),
		.q(q)
	);
endmodule
