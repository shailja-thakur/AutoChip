module dff_mux(
	input wire clk,
	input wire L,
	input wire d,
	input wire r,
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
	input wire clk,
	input wire L,
	input wire [2:0] r,
	output wire [2:0] q
);

wire q0, q1, q2;

dff_mux dff0(
	.clk(clk),
	.L(L),
	.d(q2 ^ q1),
	.r(r[0]),
	.q(q0)
);

dff_mux dff1(
	.clk(clk),
	.L(L),
	.d(q0),
	.r(r[1]),
	.q(q1)
);

dff_mux dff2(
	.clk(clk),
	.L(L),
	.d(q1),
	.r(r[2]),
	.q(q2)
);

assign q = {q2, q1, q0};

endmodule
