module dff_mux(
	input clk,
	input L,
	input d,
	input r,
	output reg q
);

always @(posedge clk) begin
	if (L) begin
		q <= r;
	} else begin
		q <= d;
	}
end

endmodule
module top_module(
	input clk,
	input L,
	input [2:0] r,
	output [2:0] q
);

reg q0, q1, q2;

// First instance
dff_mux dff0(
	.clk(clk),
	.L(L),
	.d(q1 ^ q2),
	.r(r[0]),
	.q(q0)
);

// Second instance
dff_mux dff1(
	.clk(clk),
	.L(L),
	.d(q0),
	.r(r[1]),
	.q(q1)
);

// Third instance
dff_mux dff2(
	.clk(clk),
	.L(L),
	.d(q1),
	.r(r[2]),
	.q(q2)
);

// Assign outputs
assign q = {q2, q1, q0};

endmodule
