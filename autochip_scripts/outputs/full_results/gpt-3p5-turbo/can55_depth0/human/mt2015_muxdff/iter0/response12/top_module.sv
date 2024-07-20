module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);

reg [2:0] r;
reg [2:0] q;

full_module inst1(
  .r(r_in),
  .L(L),
  .clk(clk),
  .q(q_in)
);

full_module inst2(
  .r(q[2]),
  .L(L),
  .clk(clk),
  .q(q[1])
);

full_module inst3(
  .r(q[1]),
  .L(L),
  .clk(clk),
  .q(Q)
);

always @(posedge clk) begin
  r <= {q[2], q[1], q_in};
end

endmodule
