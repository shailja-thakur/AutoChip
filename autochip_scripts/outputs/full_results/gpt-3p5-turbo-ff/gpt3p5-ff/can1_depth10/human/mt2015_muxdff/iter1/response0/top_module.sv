module flipflop(
	input clk,
	input reset,
	input D,
	output reg Q);

	always @(posedge clk) begin
		if (reset) begin
			Q <= 1'b0;
		end else begin
			Q <= D;
		end
	end
endmodule
module mux_2to1(
	input [2:0] A,
	input [2:0] B,
	input S,
	output reg Y);

	always @(*) begin
		if (S) begin
			Y <= B[0];
		end else begin
			Y <= A[0];
		end
	end
endmodule
module top_module(
	input clk,
	input L,
	input [2:0] q_in,
	input [2:0] r_in,
	output reg [2:0] Q
);

	wire [2:0] q1;
	wire [2:0] q2;
	wire [2:0] q3;

	flipflop ff1(
		.clk(clk),
		.reset(L),
		.D(r_in),
		.Q(q1)
	);

	mux_2to1 mux1(
		.A(Q),
		.B(3'b000),
		.S(L),
		.Y(q2)
	);

	mux_2to1 mux2(
		.A(q3),
		.B(q1),
		.S(L),
		.Y(q2)
	);

	flipflop ff2(
		.clk(clk),
		.reset(L),
		.D(q2),
		.Q(Q)
	);

	flipflop ff3(
		.clk(clk),
		.reset(L),
		.D(q2),
		.Q(q3)
	);

endmodule
