module top_module (
  input clk,
  input x,
  output z
);

  reg d0, d1, d2;
  wire q0, q1, q2;

  assign q0 = d0;
  assign q1 = d1;
  assign q2 = d2;

  assign z = ~(q0 ^ (q1 & ~q2) ^ (q2 | q2));

  always @(posedge clk) begin
    d0 <= x ^ q0;
    d1 <= ~q1;
    d2 <= ~q2;
  end

endmodule
