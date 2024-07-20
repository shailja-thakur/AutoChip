module top_module (
   input in1,
   input in2,
   output logic out
);

   // assign the output signal using the logical AND and NOT operations
   assign out = in1 && !in2;

endmodule
module top_module (
   input in1,
   input in2,
   output logic out
);
   
   // assign the output signal using the logical AND and NOT operations
   always_comb begin
      if (in1 && !in2)
         out = 1;
      else
         out = 0;
   end

endmodule
