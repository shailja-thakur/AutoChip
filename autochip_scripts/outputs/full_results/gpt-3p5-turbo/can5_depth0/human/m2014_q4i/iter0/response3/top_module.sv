module top_module(
   output reg out); // added reg keyword for output variable
  
   always @(*)
   begin
      out <= 0; // assigned 0 to the output variable
   end
endmodule
