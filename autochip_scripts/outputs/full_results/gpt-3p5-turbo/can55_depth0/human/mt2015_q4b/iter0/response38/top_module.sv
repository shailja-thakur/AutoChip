module top_module(
   input x,
   input y,
   output z
);
   reg z;

   always @(x, y)
   begin
      if (x) begin
         if (y) begin
            z <= 1;
         end
         else begin
            z <= 0;
         end
      end
      else begin
         z <= 1;
      end
   end

endmodule
