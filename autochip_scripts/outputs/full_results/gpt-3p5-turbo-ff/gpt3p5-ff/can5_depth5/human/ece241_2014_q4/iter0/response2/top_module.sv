module top_module (
  input clk,
  input x,
  output z
);

  reg d0, d1, d2;
  wire d0_complement, d1_complement, d2_complement;

  assign d0_complement = ~d0;
  assign d1_complement = ~d1;
  assign d2_complement = ~d2;

  xor gate_xor (x, d0, d0);
  and gate_and (x, d1, d1_complement);
  or gate_or (x, d2, d2_complement);

  xnor gate_xnor (d0, d1, d2, z);

  always @(posedge clk) begin
    d0 <= x;
    d1 <= x;
    d2 <= x;
  end
  
endmodule
