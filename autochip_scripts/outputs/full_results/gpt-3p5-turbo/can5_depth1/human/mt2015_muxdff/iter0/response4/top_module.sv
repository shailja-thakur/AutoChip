module flipflop(
	input clk,
	input D,
	output reg Q);
	
	always @(posedge clk) begin
		Q <= D;
	end
	
endmodule
module mux_2to1(
	input sel,
	input D0,
	input D1,
	output reg Y);
	
	always @(sel) begin
		if(sel) begin
			Y <= D1;
		end else begin
			Y <= D0;
		end
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

	wire q1, q2, q3;
	wire [2:0] r1, r2, r3;

	flipflop FF1(clk, q_in, q1);
	flipflop FF2(clk, q2, q3);
	flipflop FF3(clk, q3, Q);
	
	mux_2to1 MUX1(L, r_in, FF1.Q, r1);
	mux_2to1 MUX2(L, r1, FF2.Q, r2);
	mux_2to1 MUX3(L, r2, FF3.Q, r3);

	assign q_in = r3;
	
endmodule
