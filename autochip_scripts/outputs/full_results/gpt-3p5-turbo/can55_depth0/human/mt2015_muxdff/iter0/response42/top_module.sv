module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk) begin
		Q <= D;
	end
endmodule
module mux(
	input [1:0] sel,
	input D0,
	input D1,
	output reg Y);

	always @(*) begin
		case(sel)
			2'b00: Y <= D0;
			2'b01: Y <= D1;
			2'b10: Y <= D0;
			2'b11: Y <= D0;
		endcase
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire [2:0] q_out;

	flipflop ff1(.clk(clk), .D(q_in), .Q(q_out[0]));
	flipflop ff2(.clk(clk), .D(q_out[0]), .Q(q_out[1]));
	flipflop ff3(.clk(clk), .D(q_out[1]), .Q(Q));

	mux mux1(.sel({L, L}), .D0(r_in), .D1(q_out[2]), .Y(q_out[2]));
endmodule
