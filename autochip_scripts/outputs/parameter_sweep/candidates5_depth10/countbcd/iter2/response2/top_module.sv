module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  reg [2:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;
      count <= 0;
    end else begin
      if (ena[1] && count == 0) begin
        q <= q + 1;
      end
      
      if (ena[2] && count == 1) begin
        q <= q + 10;
      end
      
      if (ena[3] && count == 2) begin
        q <= q + 100;
      end
      
      if (count < 2) begin
        count <= count + 1;
      end else begin
        count <= 0;
      end
    end
  end

  assign ena = count;
  
endmodule
