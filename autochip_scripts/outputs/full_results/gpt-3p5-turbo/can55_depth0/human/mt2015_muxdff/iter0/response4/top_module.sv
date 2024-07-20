module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q);

  reg [2:0] r;
  wire [2:0] q;
  wire q1, q2;

  assign q = {q2, q1, Q};

  full_module M1(
    .r(r[2:0]),
    .L(L),
    .clk(clk),
    .q(q[2:0])
  );

  full_module M2(
    .r(q[2:0]),
    .L(L),
    .clk(clk),
    .q(q[2:0])
  );

  full_module M3(
    .r(r_in),
    .L(L),
    .clk(clk),
    .q(Q)
  );

endmodule
