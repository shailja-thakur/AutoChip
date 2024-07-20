module top_module(
  input clk,
  input reset,
  output reg [9:0] q);
  
  reg [9:0] q_next;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      q <= 0;
    else
      q <= q_next;
  end
  
  always @(posedge clk) begin
    if(reset)
      q_next <= 0;
    else if(q == 999)
      q_next <= 0;
    else
      q_next <= q + 1;
  end
  
endmodule
