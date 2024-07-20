module flipflop(
	input clk,
	input r,
	input s,
	output reg q);
	
	always @(posedge clk)
	begin
		if (r)
			q <= 1'b0;
		else if (s)
			q <= 1'b1;
	end
	
endmodule
module mux_2to1(
	input a,
	input b,
	input sel,
	output reg out);
	
	always @*
	begin
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
	
	reg ff1_q, ff2_q, ff3_q;
	wire mux1_out, mux2_out;
	
	flipflop ff1(.clk(clk), .r(L), .s(L), .q(ff1_q));
	flipflop ff2(.clk(clk), .r(L), .s(L), .q(ff2_q));
	flipflop ff3(.clk(clk), .r(L), .s(L), .q(ff3_q));
	
	mux_2to1 mux1(.a(ff1_q), .b(r_in), .sel(L), .out(mux1_out));
	mux_2to1 mux2(.a(ff2_q), .b(mux1_out), .sel(L), .out(mux2_out));
	
	assign Q = mux2_out;
	
endmodule
