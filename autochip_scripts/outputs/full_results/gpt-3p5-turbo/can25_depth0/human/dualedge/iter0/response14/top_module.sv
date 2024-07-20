module top_module(
  input clk,
  input d,
  output reg q);
  
  always @(posedge clk) begin
    q <= d;
  end
  
  always @(negedge clk) begin
    q <= d;
  end
endmodule
