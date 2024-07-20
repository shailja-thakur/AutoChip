module top_module(
  input clk,
  input d,
  output reg q);
  
  reg q_prev;
  
  always@(posedge clk) begin
    q_prev <= d;
  end
  
  always@(negedge clk) begin
    q <= q_prev;
  end
endmodule
