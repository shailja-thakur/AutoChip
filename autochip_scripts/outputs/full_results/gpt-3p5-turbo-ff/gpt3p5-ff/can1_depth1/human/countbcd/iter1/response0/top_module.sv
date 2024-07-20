module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q0, q1, q2, q3;

  always @(posedge clk or posedge reset) begin
    if (reset)
      begin
         q0 <= 4'b0000;
         q1 <= 4'b0000;
         q2 <= 4'b0000;
         q3 <= 4'b0000;
         ena <= 3'b000;
      end
    else
      begin
         if (q0 == 4'b1001)
           q0 <= 4'b0000;
         else
           q0 <= q0 + 1;
         
         if (q0[3] == 1)
           ena <= ena | 3'b001;
         
         if (q1 == 4'b1001)
           q1 <= 4'b0000;
         else if (ena[0] == 1)
           q1 <= q1 + 1;
         
         if (q1[3] == 1)
           ena <= ena | 3'b010;
         
         if (q2 == 4'b1001)
           q2 <= 4'b0000;
         else if (ena[1] == 1)
           q2 <= q2 + 1;
         
         if (q2[3] == 1)
           ena <= ena | 3'b100;
         
         if (q3 == 4'b1001)
           q3 <= 4'b0000;
         else if (ena[2] == 1)
           q3 <= q3 + 1;
      end
  end
  
  assign q = {q3, q2, q1, q0};
  
endmodule
