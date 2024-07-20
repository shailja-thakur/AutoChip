module top_module(
  input clk,
  input d,
  output reg q);
  
  reg clk_prev;
  
  always @(posedge clk) begin
    clk_prev <= clk;
  end
  
  always @(posedge clk or negedge clk_prev) begin
    q <= d;
  end
  
endmodule
