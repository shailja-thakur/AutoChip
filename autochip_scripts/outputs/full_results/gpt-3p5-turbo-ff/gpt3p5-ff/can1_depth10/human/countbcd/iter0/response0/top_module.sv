module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);
  
  reg [3:1] d;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 0;
    else if (ena[1])
      q <= q + 2;
    else if (ena[2])
      q <= q + 4;
    else if (ena[3])
      q <= q + 8;
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      d <= 3'b000;
    else
      d <= {ena[2], ena[1], ena[3]};
  end
  
  assign ena = d;
  
endmodule
