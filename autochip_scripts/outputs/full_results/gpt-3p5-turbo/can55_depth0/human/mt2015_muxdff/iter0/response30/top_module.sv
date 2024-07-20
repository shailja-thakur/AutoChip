module flipflop(
	input clk,
	input D,
	output reg Q);
	
	always@(posedge clk)
		Q <= D;
endmodule
module MUX_2to1(
	input I0,
	input I1,
	input S,
	output reg Out);
	
	always@(I0, I1, S)
		begin
			case(S)
				0: Out = I0;
				1: Out = I1;
				default: Out = I0;
			endcase
		end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire [2:0] r;
	wire [2:0] q_next;
	wire [2:0] q_ff;
	
	assign r = r_in;
	
	flipflop FF1(clk, q_in, q_ff[0]);
	flipflop FF2(clk, q_ff[0], q_ff[1]);
	flipflop FF3(clk, q_ff[1], q_ff[2]);
	
	MUX_2to1 MUX(L, q_ff[1], q_ff[2], q_next[0]);
	MUX_2to1 MUX(q_ff[1], q_ff[2], q_ff[0], q_next[1]);
	MUX_2to1 MUX(q_ff[2], q_ff[1], q_in, q_next[2]);
	
	always@(posedge clk)
		if(L)
			q_ff <= r;
		else
			q_ff <= q_next;
	
	assign Q = q_ff[2];
	
endmodule
