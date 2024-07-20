module simple_register (
	input clk,
	input d,
	input ar,
	output logic q
);

	always @(posedge clk or posedge ar) begin
		if (ar)
			q <= 0;
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

	simple_register dut (
		.clk(clk),
		.d(d),
		.ar(ar),
		.q(q)
	);

endmodule
