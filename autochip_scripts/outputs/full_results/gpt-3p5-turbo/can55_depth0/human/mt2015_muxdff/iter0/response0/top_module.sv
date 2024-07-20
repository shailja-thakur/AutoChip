module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk)
	begin
		Q <= D;
	end

endmodule
module mux_2to1(
	input A,
	input B,
	input select,
	output reg Y);

	always @*
	begin
		if (select)
			Y <= B;
		else
			Y <= A;
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire w1, w2, w3;
	reg [2:0] q;
	always @(posedge clk)
	begin
		if (L)
			q <= r_in;
		else
			q <= {q[1] ^ q[2], q[0], q[2]};
	end

	flipflop DFF0(.clk(clk), .D(q_in), .Q(w1));
	flipflop DFF1(.clk(clk), .D(w1), .Q(w2));
	mux_2to1 MUX(.A(w1), .B(w2), .select(L), .Y(Q));

endmodule
