module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk)
		begin
			Q <= D;
		end
endmodule
module mux2to1(
	input A,
	input B,
	input sel,
	output reg Y);

	always @(A or B or sel)
		begin
			if(sel)
				Y <= B;
			else
				Y <= A;
		end
endmodule
module top_module (
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

	reg [2:0] q1, q2, q3;
	reg d1, d2, d3;
	reg out_mux1, out_mux2, out_mux3;
	wire sel1, sel2, sel3;

	flipflop FF1 (.clk(clk), .D(d1), .Q(q1));
	flipflop FF2 (.clk(clk), .D(d2), .Q(q2));
	flipflop FF3 (.clk(clk), .D(d3), .Q(q3));

	mux2to1 MUX1 (.A(q1), .B(r_in), .sel(sel1), .Y(out_mux1));
	mux2to1 MUX2 (.A(q2), .B(r_in), .sel(sel2), .Y(out_mux2));
	mux2to1 MUX3 (.A(q3), .B(r_in), .sel(sel3), .Y(out_mux3));

	always @(posedge clk)
		begin
			d1 = r_in;
			d2 = out_mux1;
			d3 = out_mux2;

			if(L)
				begin
					Q = q_in;
				end
			else
				begin
					{sel1, sel2, sel3} = {q2 ^ q3, q1, q3};
					Q = out_mux3;
				end
		end
endmodule
