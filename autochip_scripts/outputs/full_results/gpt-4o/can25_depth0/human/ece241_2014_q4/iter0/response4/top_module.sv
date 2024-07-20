module top_module (
  input clk,
  input x,
  output z
);
  // Declare flip-flop output signal
  reg q1, q2, q3;

  // Flip-flop logic (D-type flip-flops)
  always @(posedge clk) begin
    q1 <= x ^ q1;
    q2 <= x & ~q2;
    q3 <= x | ~q3;
  end

  // XNOR gate for final output
  assign z = ~(q1 ^ q2 ^ q3);

endmodule
