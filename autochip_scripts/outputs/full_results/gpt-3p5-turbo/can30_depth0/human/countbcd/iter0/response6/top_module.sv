module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

   always @(posedge clk or posedge reset) begin
      if (reset)
         q <= 0;
      else if (ena[3])
         q <= q + 1;
   end
   
   assign ena[2] = (q[3:0] == 9);
   assign ena[1] = (q[7:4] == 9);
   assign ena[0] = (q[11:8] == 9);
   
endmodule
