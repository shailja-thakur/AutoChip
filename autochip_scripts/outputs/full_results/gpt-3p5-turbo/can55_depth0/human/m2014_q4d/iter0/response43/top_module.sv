module top_module (
  input clk,
  input in,
  output logic out
);
  
  logic d_ff_out;
  logic xor_out;
  
  xor_gate u1(
    .a(in),
    .b(out),
    .y(xor_out)
  );
  
  d_ff u2(
    .d(xor_out),
    .clk(clk),
    .q(d_ff_out)
  );
  
  assign out = d_ff_out;
  
endmodule
module xor_gate (
  input a,
  input b,
  output logic y
);

  assign y = a ^ b;

endmodule
module d_ff (
  input d,
  input clk,
  output logic q
);

  always_ff @(posedge clk) begin
    q <= d;
  end

endmodule
