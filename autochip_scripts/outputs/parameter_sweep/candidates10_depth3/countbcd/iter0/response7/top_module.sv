module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 16'b0000;
    else if (ena[3])
      q <= q + 16'b0001;
    else if (ena[2])
      q <= {q[15:3], q[2:0]} + 16'b0001;
    else if (ena[1])
      q <= {q[15:7], q[6:0]} + 16'b0001;
  end

endmodule
