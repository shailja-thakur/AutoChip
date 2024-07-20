module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

  // Create wire for AND gate output
  wire [99:0] and_out;
  
  // Create wire for OR gate output
  wire [99:0] or_out;
  
  // Create wire for XOR gate output
  wire [99:0] xor_out;
  
  // Instantiate AND gate
  and_gate and1 (
    .in(in),
    .out(and_out)
  );
  
  // Instantiate OR gate
  or_gate or1 (
    .in(in),
    .out(or_out)
  );
  
  // Instantiate XOR gate
  xor_gate xor1 (
    .in(in),
    .out(xor_out)
  );
  
  // Assign outputs
  assign out_and = and_out[0];
  assign out_or = or_out[0];
  assign out_xor = xor_out[0];

endmodule
module and_gate (
  input [99:0] in,
  output [99:0] out
);
 
  // Generate AND gate for each bit position
  genvar i;
  generate
    for (i = 0; i < 100; i = i+1) begin
      and_gate_bit and_bit (
        .in1(in[i]),
        .in2(out[i]),
        .out(out[i+1])
      );
    end
  endgenerate

endmodule
module and_gate_bit (
  input in1,
  input in2,
  output out
);

  assign out = in1 & in2;

endmodule
module or_gate (
  input [99:0] in,
  output [99:0] out
);
 
  // Generate OR gate for each bit position
  genvar i;
  generate
    for (i = 0; i < 100; i = i+1) begin
      or_gate_bit or_bit (
        .in1(in[i]),
        .in2(out[i]),
        .out(out[i+1])
      );
    end
  endgenerate

endmodule
module or_gate_bit (
  input in1,
  input in2,
  output out
);

  assign out = in1 | in2;

endmodule
module xor_gate (
  input [99:0] in,
  output [99:0] out
);
 
  // Generate XOR gate for each bit position
  genvar i;
  generate
    for (i = 0; i < 100; i = i+1) begin
      xor_gate_bit xor_bit (
        .in1(in[i]),
        .in2(out[i]),
        .out(out[i+1])
      );
    end
  endgenerate

endmodule
module xor_gate_bit (
  input in1,
  input in2,
  output out
);

  assign out = in1 ^ in2;

endmodule
