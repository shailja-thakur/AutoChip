module flipflop(
	input clk,
	input reset,
	input D,
	output reg q);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			q <= D;
		end
	end
endmodule
module mux(
	input [1:0] s,
	input d0,
	input d1,
	output reg y);
	
	always @(*) begin
		case (s)
			2'b00: y = d0;
			2'b01: y = d1;
			default: y = 0;
		endcase
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire q_out;
	
	flipflop ff(
		.clk(clk),
		.reset(L),
		.D(r_in),
		.q(q_out)
	);
	
	mux mx(
		.s(L),
		.d0(q_out),
		.d1(q_in),
		.y(Q)
	);
	
endmodule
