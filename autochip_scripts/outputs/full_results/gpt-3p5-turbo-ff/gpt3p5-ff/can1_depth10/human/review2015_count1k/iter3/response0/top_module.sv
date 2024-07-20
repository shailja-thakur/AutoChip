module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

  reg [9:0] count;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 0;
    else if (count == 999)
      count <= 0;
    else
      count <= count + 1;
  end
  
  always @(posedge clk)
    if (reset)
      q <= 0;
    else
      q <= count;
  
endmodule
