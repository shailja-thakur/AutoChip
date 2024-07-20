module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

   always @(*) begin
      if (~a & ~b & ~d)
         q = 1'b0;
      else if (~a & ~c & d)
         q = 1'b0;
      else if (a & ~b & ~c)
         q = 1'b0;
      else
         q = 1'b1;
   end
   
endmodule
