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
	input A,
	input B,
	input S,
	output reg Y);

	always @(*) begin
		if (S) begin
			Y <= B;
		end else begin
			Y <= A;
		end
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

	wire q1;
	wire q2;
	wire q3;

	flipflop ff1(
		.clk(clk),
		.reset(L),
		.D(r_in),
		.Q(q1)
	);

	mux_2to1 mux1(
		.A(Q),
		.B(3'b0),
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
