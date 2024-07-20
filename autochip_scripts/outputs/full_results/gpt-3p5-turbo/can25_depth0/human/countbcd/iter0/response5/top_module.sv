module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      q <= 0;
    end else if(ena[1]) begin
      q <= q + 16;
    end else if(ena[2]) begin
      q <= q + 256;
    end else if(ena[3]) begin
      q <= q + 4096;
    end
  end
endmodule
