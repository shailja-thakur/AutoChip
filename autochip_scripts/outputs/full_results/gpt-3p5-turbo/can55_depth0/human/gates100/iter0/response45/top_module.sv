module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);
  
  wire [99:0] and_gates;
  assign out_and = &and_gates;
  
  wire [99:0] or_gates;
  assign out_or = |or_gates;
  
  wire [99:0] xor_gates;
  assign out_xor = ^xor_gates;
  
  generate
    genvar i;
    for (i = 0; i < 100; i = i + 1) begin : gate_gen
      and_gate and_gate_instance (
        .in1(in[i]),
        .in2(and_gates[i])
      );
      
      or_gate or_gate_instance (
        .in1(in[i]),
        .in2(or_gates[i])
      );
      
      xor_gate xor_gate_instance (
        .in1(in[i]),
        .in2(xor_gates[i])
      );
    end
  endgenerate

endmodule
module and_gate (
  input in1,
  input in2,
  output out
);
  
  assign out = in1 & in2;
  
endmodule
module or_gate (
  input in1,
  input in2,
  output out
);
  
  assign out = in1 | in2;
  
endmodule
module xor_gate (
  input in1,
  input in2,
  output out
);
  
  assign out = in1 ^ in2;
  
endmodule
