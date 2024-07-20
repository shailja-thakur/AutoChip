module top_module (
	input clk,
	input in,
	output logic out
);

  logic d;
  logic q;

  // Instantiate the XOR gate
  xor_gate xor_1(.a(in), .b(out), .z(d));

  // Instantiate the D flip-flop
  always @(posedge clk) begin
    q <= d;
  end

  assign out = q;

endmodule
module xor_gate (
	input a,
	input b,
	output z
);
  
  assign z = a ^ b;

endmodule
