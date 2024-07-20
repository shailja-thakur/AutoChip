module flipflop(
	input clk,
	input D,
	output reg Q
);

	always @(posedge clk) begin
		Q <= D;
	end

endmodule
module mux21(
	input S,
	input D0,
	input D1,
	output reg Y
);

	always @(*) begin
		if (S == 1'b0)
			Y = D0;
		else
			Y = D1;
	end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

	reg [2:0] q1, q2, q3;
	reg r1, r2, r3;
	wire d1, d2, d3, d4, d5, d6;

	flipflop ff1(.clk(clk), .D(r_in), .Q(q1));
	flipflop ff2(.clk(clk), .D(q2), .Q(q2));
	flipflop ff3(.clk(clk), .D(q3), .Q(q3));

	mux21 mux1(.S(L), .D0(q_in), .D1(q3), .Y(d1));
	mux21 mux2(.S(q3[0]), .D0(q_in), .D1(q3), .Y(d2));
	mux21 mux3(.S(q3[1]), .D0(q_in), .D1(q3), .Y(d3));

	mux21 mux4(.S(L), .D0(d1 ^ d2), .D1(r_in), .Y(d4));
	mux21 mux5(.S(q3[0]), .D0(d1 ^ d2), .D1(r_in), .Y(d5));
	mux21 mux6(.S(q3[1]), .D0(d1 ^ d2), .D1(r_in), .Y(d6));

	flipflop ff4(.clk(clk), .D(d4), .Q(r1));
	flipflop ff5(.clk(clk), .D(d5), .Q(r2));
	flipflop ff6(.clk(clk), .D(d6), .Q(r3));

	always @(posedge clk) begin
		if (L) begin
			q1 <= r_in;
		end else begin
			q1 <= {q1[1] ^ q1[2], q1[0], q1[2]};
		end

		q2 <= {q1[1], q1[2]};
		q3 <= {q2[1], q2[2]};
		Q <= r3;
	end
	
endmodule
