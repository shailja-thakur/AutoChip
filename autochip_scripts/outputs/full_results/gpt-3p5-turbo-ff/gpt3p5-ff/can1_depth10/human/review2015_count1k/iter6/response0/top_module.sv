module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

  reg [10:0] count;
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 0;
    else if (state == 1 && count == 999)
      count <= 0;
    else if (state == 0)
      count <= count + 1;
  end
  
  always @(posedge clk) begin
    if (reset)
      state <= 0;
    else if (state == 0 && count == 999)
      state <= 1;
    else if (state == 1)
      state <= 0;
  end
  
  assign q = count[9:0];
  
endmodule
