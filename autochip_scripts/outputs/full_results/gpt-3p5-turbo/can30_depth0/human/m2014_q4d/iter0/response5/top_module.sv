module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_output;
  logic d;
  
  xor2 xor_gate(
    .a(in),
    .b(out),
    .z(xor_output)
  );
  
  always @(posedge clk) begin
    d <= xor_output;
  end
  
  always @(posedge clk) begin
    out <= d;
  end
  
endmodule
module xor2 (
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
