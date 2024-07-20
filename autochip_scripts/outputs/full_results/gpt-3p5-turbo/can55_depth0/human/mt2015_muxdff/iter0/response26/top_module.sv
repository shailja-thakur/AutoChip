module flipflop(input clk, input D, output reg Q);

	always @(posedge clk)
	begin
		Q <= D;
	end

endmodule
module mux_2to1(input a, input b, input sel, output reg out);

	always @(a or b or sel)
	begin
		out <= (sel == 0) ? a : b;
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire [2:0] r;
	wire [2:0] q;
	
	flipflop ff1 (.clk(clk), .D(q[0]), .Q(q[0]));
	flipflop ff2 (.clk(clk), .D(q[1]), .Q(q[1]));
	flipflop ff3 (.clk(clk), .D(q[2]), .Q(q[2]));
	
	mux_2to1 mux1 (.a(q[1]), .b(q[2]), .sel(L), .out(q[0]));
	
	assign r = r_in;
	assign q = q_in;
	
	always @(posedge clk)
	begin
		if (L)
		begin
			Q <= r;
		end
		else
		begin
			Q <= {q[1] ^ q[2], q[0], q[2]};
		end
	end

endmodule
