module top_module (
  input clk,
  input in,
  output logic out
);
  
  logic xor_output;
  logic d_input;
  
  xor_gate xor1 (
    .A(in),
    .B(out),
    .Z(xor_output)
  );
  
  flip_flop d_ff (
    .clk(clk),
    .D(xor_output),
    .Q(out)
  );
  
endmodule
module xor_gate (
  input A,
  input B,
  output logic Z
);
  assign Z = A ^ B;
endmodule
module flip_flop (
  input clk,
  input D,
  output logic Q
);
  always @(posedge clk) begin
    Q <= D;
  end
endmodule
