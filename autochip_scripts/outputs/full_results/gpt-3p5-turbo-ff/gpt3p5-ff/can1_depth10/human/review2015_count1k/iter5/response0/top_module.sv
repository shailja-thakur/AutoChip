module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

  reg [10:0] count;
  
  always @(posedge clk) begin
    if (reset)
      count <= 0;
    else if (count == 1000)
      count <= 0;
    else
      count <= count + 1;
  end
  
  always @(posedge clk) begin
    if (reset)
      q <= 0;
    else
      q <= count[9:0];
  end
  
endmodule
