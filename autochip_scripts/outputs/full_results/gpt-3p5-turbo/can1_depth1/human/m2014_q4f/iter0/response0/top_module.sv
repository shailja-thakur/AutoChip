module top_module (
  input in1,
  input in2,
  output logic out
);
 
  // Instantiate the AND gate
  and_gate and1(.in1(in1), .in2(~in2), .out(out));
endmodule
module and_gate (
  input in1,
  input in2,
  output out
);
 
  // Perform the AND operation
  assign out = in1 & in2;
endmodule
