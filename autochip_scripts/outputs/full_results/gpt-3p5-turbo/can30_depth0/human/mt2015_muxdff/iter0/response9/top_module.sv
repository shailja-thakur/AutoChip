module flipflop(
	input clk,
	input r,
	input d,
	output reg q );

	always @(posedge clk)
		if (r)
			q <= 0;
		else 
			q <= d;
endmodule
module mux_2to1(
	input i0,
	input i1,
	input sel,
	output reg y );

	always @*
		case (sel)
			1'b0: y = i0;
			1'b1: y = i1;
		endcase
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q );

	wire q0;
	wire q1;
	wire q2;
	wire r;

	flipflop ff0(.clk(clk), .r(r_in), .d(q_in), .q(q0));
	flipflop ff1(.clk(clk), .r(r_in), .d(q0), .q(q1));
	flipflop ff2(.clk(clk), .r(r_in), .d(q1), .q(q2));

	mux_2to1 mux(.i0(q0), .i1(q2), .sel(L), .y(Q));

	assign r = r_in;

endmodule
