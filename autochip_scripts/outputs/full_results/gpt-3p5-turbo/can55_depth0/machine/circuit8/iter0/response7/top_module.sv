module top_module (
   input clock,
   input a,
   output reg p,
   output reg q
);

   reg q_reg;
 
   always @(negedge clock)
   begin
      q_reg <= a;
   end
 
   always @(a or clock)
   begin
      if (clock)
         p <= a;
   end
 
   assign q = q_reg;

endmodule
