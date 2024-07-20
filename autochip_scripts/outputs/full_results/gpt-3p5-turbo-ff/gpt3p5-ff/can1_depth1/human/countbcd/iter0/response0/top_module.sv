module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);
  
  reg [3:0] q0, q1, q2, q3;
  reg [2:0] ena_d;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      begin
         q0 <= 4'b0000;
         q1 <= 4'b0000;
         q2 <= 4'b0000;
         q3 <= 4'b0000;
         ena_d <= 3'b111;
      end
    else
      begin
         q0 <= q0 + 1;
         
         if (ena_d[0])
           q1 <= q1 + 1;
         
         if (ena_d[1])
           q2 <= q2 + 1;
         
         if (ena_d[2])
           q3 <= q3 + 1;
        
         ena_d <= ena;
      end
  end
  
  assign ena = ena_d;
  
  assign q = {q3, q2, q1, q0};
  
endmodule
