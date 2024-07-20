module xor_gate (
  input a,
  input b,
  output logic c
);
  assign c = a ^ b;
endmodule
module d_ff (
  input clk,
  input d,
  output logic q
);
  always @(posedge clk) begin
    q <= d;
  end
endmodule
module top_module (
  input clk,
  input in,
  output logic out
);
  wire xor_output;
  xor_gate xor_inst (
    .a(in),
    .b(out),
    .c(xor_output)
  );
  
  d_ff d_ff_inst (
    .clk(clk),
    .d(xor_output),
    .q(out)
  );
endmodule
