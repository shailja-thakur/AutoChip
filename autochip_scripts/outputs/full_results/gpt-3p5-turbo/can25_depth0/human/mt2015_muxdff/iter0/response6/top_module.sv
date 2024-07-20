module flipflop (
	input clk,
	input D,
	output reg Q);
	
	always @(posedge clk) begin
		Q <= D;
	end
endmodule
module two_to_one_mux(
	input [1:0] S,
	input D0,
	input D1,
	output reg Y);
	
	always @(*) begin
		if (S == 2'b00)
			Y <= D0;
		else if (S == 2'b01)
			Y <= D1;
		else
			Y <= 1'bx;
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire [1:0] mux_sel;
	wire flop_out;
	
	assign mux_sel[0] = L;
	assign mux_sel[1] = q_in[0];
	
	flipflop flop(clk, r_in, flop_out);
	two_to_one_mux mux(mux_sel, q_in[1], flop_out, Q);
	
endmodule
