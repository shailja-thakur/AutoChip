module top_module (
  input clk,
  input j,
  input k,
  output reg Q
);

  always @(posedge clk)
  begin
    if (j & !k)     // added condition for j & !k
      Q <= 1;       // set Q to 1 when j & !k
    else if (!j & k) // changed condition from !k & Q to !j & k
      Q <= 0;
    else if (j & k) // changed condition from j & k
      Q <= ~Q;      // toggling Q
  end

endmodule
