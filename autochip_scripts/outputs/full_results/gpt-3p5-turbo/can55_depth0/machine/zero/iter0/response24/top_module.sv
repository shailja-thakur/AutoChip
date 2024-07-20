module top_module(
   output reg zero);

   always @(posedge clk) begin
      zero <= 0;   // assigning the output 'zero' to the value 0
   end

endmodule
