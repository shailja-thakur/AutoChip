module top_module (
  input clk,
  input x,
  output z
);
  
  reg d1, d2, d3;
  wire xor_out, and_out, or_out;

  // XOR gate
  xor_gate xor1(
    .a(d1),
    .b(d1),
    .z(xor_out)
  );

  // AND gate
  and_gate and1(
    .a(d2),
    .b(~d2),
    .z(and_out)
  );

  // OR gate
  or_gate or1(
    .a(d3),
    .b(~d3),
    .z(or_out)
  );

  // XNOR gate
  xnor_gate xnor1(
    .a(xor_out),
    .b(and_out),
    .c(or_out),
    .z(z)
  );

  always @(posedge clk) begin
    // Positive edge triggered D flip-flops
    d1 <= xor_out;
    d2 <= ~d2;
    d3 <= ~d3;
  end

endmodule
module xor_gate (
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output z
);
  assign z = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output z
);
  assign z = a | b;
endmodule
module xnor_gate (
  input a,
  input b,
  input c,
  output z
);
  assign z = ~(a ^ b ^ c);
endmodule
