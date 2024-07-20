module top_module (
  input clk,
  input x,
  output z
);

  reg d1, d2, d3;
  wire xor_out, and_out, or_out;

  // D flip flops
  always @(posedge clk) begin
    d1 <= xor_out;
    d2 <= ~d2;
    d3 <= ~d3;
  end

  // XOR gate
  assign xor_out = x ^ d1;

  // AND gate
  assign and_out = x & ~d2;

  // OR gate
  assign or_out = x | ~d3;

  // XNOR gate
  assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
