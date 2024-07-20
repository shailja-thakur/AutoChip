module top_module (
   input in1,
   input in2,
   output logic out
);
   // Logic to compute the output
   assign out = ~(in1 | in2);
endmodule
