module top_module (
  input clk,
  input in,
  output logic out
);

  reg out_reg;

  always_ff @(posedge clk)
    out_reg <= in ^ out_reg;

  assign out = out_reg;

endmodule
