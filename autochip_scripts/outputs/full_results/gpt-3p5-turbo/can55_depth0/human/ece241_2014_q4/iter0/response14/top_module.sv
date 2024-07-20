module top_module (
    input clk,
    input x,
    output reg z
);

  reg d1, d2;

  always @(posedge clk)
    d1 <= (x ^ d1);
  
  always @(posedge clk)
    d2 <= (~(x & d2));
  
  always @(posedge clk)
    z <= (~((d1 ^ d2) ^ z));

endmodule
