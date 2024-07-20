module top_module (
	input clk,
	input in,
	output logic out
);

  logic xor_output;
  logic d_input;

  // Instantiate XOR gate
  xor_gate xor1(
    .in1(in),
    .in2(out),
    .out(xor_output)
  );

  // Instantiate D flip-flop
  d_ff d_ff1(
    .clk(clk),
    .d(xor_output),
    .q(out)
  );
  
endmodule
module xor_gate (
  input in1,
  input in2,
  output out
);
  assign out = in1 ^ in2;
endmodule
module d_ff (
  input clk,
  input d,
  output reg q
);
  always @(posedge clk) begin
    q <= d;
  end
endmodule
