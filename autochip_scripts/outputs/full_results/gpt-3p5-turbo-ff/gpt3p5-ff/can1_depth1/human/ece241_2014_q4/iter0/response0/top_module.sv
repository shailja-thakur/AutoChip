module top_module (
    input clk,
    input x,
    output z
);

  reg flop1;
  reg flop2;
  reg flop3;

  assign z = ~(flop1 ^ flop2 ^ flop3);

  always @(posedge clk) begin
    flop1 <= x ^ flop1;
    flop2 <= ~flop1 & flop2;
    flop3 <= ~flop2 | flop3;
  end

endmodule
