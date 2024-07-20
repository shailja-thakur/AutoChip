module flipflop (
    input clk,
    input rst,
    input d,
    output reg q
);

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end

endmodule
module mux2to1 (
    input s,
    input d0,
    input d1,
    output reg y
);

	always @ (s or d0 or d1) begin
		if (s) begin
			y <= d1;
		end else begin
			y <= d0;
		end
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire q_temp0, q_temp1, q_temp2;
	wire r_temp0, r_temp1, r_temp2;

	flipflop ff0(
		.clk(clk),
		.rst(!L),
		.d(q_in),
		.q(q_temp0)
	);

	flipflop ff1(
		.clk(clk),
		.rst(!L),
		.d({q_temp0, r_in}),
		.q(q_temp1)
	);

	flipflop ff2(
		.clk(clk),
		.rst(!L),
		.d({q_temp1, r_temp0}),
		.q(Q)
	);

	mux2to1 mux0(
		.s(r_temp0),
		.d0(q_temp1),
		.d1(q_in),
		.y(r_temp1)
	);

	mux2to1 mux1(
		.s(r_temp1),
		.d0(q_temp0),
		.d1(r_in),
		.y(r_temp2)
	);

	mux2to1 mux2(
		.s(r_temp2),
		.d0(q_temp2),
		.d1(q_temp1),
		.y(q_temp0)
	);

endmodule
