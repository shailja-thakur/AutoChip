module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  reg [15:0] next_q;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      next_q <= 0;
    end else begin
      if (ena[1]) begin
        next_q[7:4] <= next_q[7:4] + 1;
      end
      if (ena[2]) begin
        next_q[11:8] <= next_q[11:8] + 1;
      end
      if (ena[3]) begin
        next_q[15:12] <= next_q[15:12] + 1;
      end
      q <= next_q;
    end
  end
  
endmodule
