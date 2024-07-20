module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  reg [3:0] q0;
  reg [3:0] q1;
  reg [3:0] q2;
  reg [3:0] q3;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q0 <= 0;
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
    end else begin
      if (ena[0])
        q0 <= (q0 == 9) ? 0 : (q0 + 1);
      if (ena[1])
        q1 <= (q1 == 9) ? 0 : (q1 + 1);
      if (ena[2])
        q2 <= (q2 == 9) ? 0 : (q2 + 1);
      q3 <= (q3 == 9) ? 0 : (q3 + 1);
    end
  end
  
  assign q = {q3, q2, q1, q0};
  
endmodule
