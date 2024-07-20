module flipflop(
	input clk,
	input D,
	output reg Q );

	always @(posedge clk) begin
		if (L)
			Q <= D;
		else
			Q <= Q;
	end
endmodule
module two_one_mux(
	input S,
	input D0,
	input D1,
	output reg Q );

	always @(*) begin
		if (S == 0)
			Q <= D0;
		else
			Q <= D1;
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q );

	wire [2:0] q_tmp;
	wire [2:0] r_tmp;

	flipflop flipflop_inst_1 (.clk(clk), .D(q_in), .Q(q_tmp[0]));
	flipflop flipflop_inst_2 (.clk(clk), .D(q_tmp[0]), .Q(q_tmp[1]));
	flipflop flipflop_inst_3 (.clk(clk), .D(q_tmp[2]), .Q(q_tmp[2]));

	two_one_mux mux_inst_1 (.S(L), .D0(r_in), .D1(q_tmp[1]), .Q(r_tmp[0]));
	two_one_mux mux_inst_2 (.S(L), .D0(q_tmp[2]), .D1(r_tmp[0]), .Q(r_tmp[1]));
	two_one_mux mux_inst_3 (.S(L), .D0(r_tmp[1]), .D1(q_tmp[2]), .Q(Q));

endmodule
