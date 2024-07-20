module top_module (
  input clk,
  input in,
  output reg out
);
  always @(posedge clk) begin
    out <= #1 in ^ out;
  end
endmodule
