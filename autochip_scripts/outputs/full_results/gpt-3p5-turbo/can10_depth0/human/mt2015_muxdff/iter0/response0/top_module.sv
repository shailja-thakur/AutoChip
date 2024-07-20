module flipflop_module(
	input clk,
	input reset,
	input D,
	output reg Q);

	always @(posedge clk, posedge reset) begin
		if (reset)
			Q <= 1'b0;
		else
			Q <= D;
	end

endmodule
module mux21_module(
	input a,
	input b,
	input sel,
	output reg out);

	always @(a, b, sel) begin
		if (sel)
			out <= b;
		else
			out <= a;
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire [2:0] q;
	wire [2:0] r;

	assign q = q_in;
	assign r = r_in;

	flipflop_module ff1(
		.clk(clk),
		.reset(L),
		.D(r),
		.Q(q[0])
	);

	flipflop_module ff2(
		.clk(clk),
		.reset(L),
		.D(q[1] ^ q[2]),
		.Q(q[1])
	);

	flipflop_module ff3(
		.clk(clk),
		.reset(L),
		.D(q[0] ^ q[2]),
		.Q(q[2])
	);

	mux21_module mux(
		.a(q[1]),
		.b(q[0]),
		.sel(L),
		.out(Q)
	);

endmodule
