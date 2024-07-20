module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
  
   // XNOR gate implementation
   assign wire xnor_output = in1 ^ in2;

   // XOR gate implementation
   assign out = xnor_output ^ in3;
  
endmodule
