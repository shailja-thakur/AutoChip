module flipflop(input clk, input D, output reg Q);
	always @(posedge clk) begin
		Q <= D;
	end
endmodule
module mux_2to1(input sel, input A, input B, output reg Y);
	always @ (*) begin
		if (sel == 0)
			Y = A;
		else
			Y = B;
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	reg [2:0] q;
	wire mux_out;
	
	flipflop FF1(clk, q[0], mux_out);
	flipflop FF2(clk, q[1], mux_out);
	flipflop FF3(clk, q[2], mux_out);
	
	mux_2to1 MUX(L, q[1], q[2], mux_out);
	
	always @(posedge clk) begin
		if (L) begin
			q <= r_in;
		end else begin
			q <= {q[1] ^ q[2], q[0], q[2]};
		end
	end
	
	assign Q = q_in;
endmodule
