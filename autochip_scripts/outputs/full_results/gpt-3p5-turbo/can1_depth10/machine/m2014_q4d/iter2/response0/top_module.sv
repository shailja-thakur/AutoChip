module top_module (
  input clk,
  input in,
  output reg out
);

  always_ff @(posedge clk) begin
    if (clk)
      out <= ~out;
  end
  
endmodule
