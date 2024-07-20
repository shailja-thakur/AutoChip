module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

  reg [2:0] q;
  wire [2:0] q_sub;
  wire d;

  submodule submodule1(
	.clk(clk),
	.r(r_in),
	.L(L),
	.Q(q_sub[0])
  );

  submodule submodule2(
	.clk(clk),
	.r(r_in),
	.L(L),
	.Q(q_sub[1])
  );

  submodule submodule3(
	.clk(clk),
	.r(r_in),
	.L(L),
	.Q(q_sub[2])
  );

  mux2to1 mux(
	.i0(q_sub[2]),
	.i1(q_sub[1]),
	.s(L),
	.o(d)
  );

  always @(posedge clk) begin
	if (L) begin
	  Q <= r_in;
	  q[0] <= r_in[0];
	  q[1] <= r_in[1];
	  q[2] <= r_in[2];
	end else begin
	  q[0] <= d;
	  q[1] <= q[0];
	  q[2] <= q[1];
	  Q <= q[2];
	end
  end

endmodule
module submodule(
	input clk,
	input L,
	input [2:0] r,
	output reg Q
);

  always @(posedge clk) begin
	if (L) begin
	  Q <= r;
	end else begin
	  Q <= {Q[1] ^ Q[2], Q[0], Q[2]};
	end
  end

endmodule
module mux2to1(
	input i0,
	input i1,
	input s,
	output reg o
);

  always @(*) begin
	if (s) begin
	  o = i1;
	end else begin
	  o = i0;
	end
  end

endmodule
