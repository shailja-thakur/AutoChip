module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  always @(posedge clk) begin
    if (L) // check if load signal is asserted
      Q <= R; // load value into Q
    else if (E) // check if shift enable signal is asserted
      Q <= w; // shift the input w into Q
  end

endmodule
