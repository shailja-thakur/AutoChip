module top_module(
  input clk,
  input d,
  output reg q,
  reg q_prev);
  
  always @(posedge clk) begin
    q_prev <= q;
  end
  
  always @(posedge clk) begin
    if (q_prev == 0 && q == 1) begin
      q <= d;
    end
  end
  
endmodule
