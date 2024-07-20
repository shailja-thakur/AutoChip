module flipflop(
	input clk,
	input reset,
	input [2:0] D,
	output reg [2:0] Q);

	always @(posedge clk) begin
		if (reset) begin
			Q <= 3'b000;
		end else begin
			Q <= D;
		end
	end
endmodule
module mux_2to1(
	input [2:0] A,
	input [2:0] B,
	input S,
	output reg [2:0] Y);

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
module mt2015_muxdff_tb();
	reg clk;
	reg L;
	reg [2:0] q_in;
	reg [2:0] r_in;
	wire [2:0] Q;

	top_module uut(
		.clk(clk),
		.L(L),
		.q_in(q_in),
		.r_in(r_in),
		.Q(Q)
	);

	initial begin
		clk = 0;
		L = 0;
		q_in = 3'b000;
		r_in = 3'b000;
		#5;
		L = 1;
		q_in = 3'b010;
		r_in = 3'b001;
		#5;
		L = 0;
		q_in = 3'b110;
		r_in = 3'b100;
		#10;
		$finish;
	end

	always #5 clk = ~clk;

endmodule
