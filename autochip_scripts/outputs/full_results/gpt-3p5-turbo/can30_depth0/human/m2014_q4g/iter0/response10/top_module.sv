module top_module (
  input in1,
  input in2,
  input in3,
  output logic out
);
  
  xor #(2) xor1(.a(in1), .b(in2), .z(out));
  
endmodule
