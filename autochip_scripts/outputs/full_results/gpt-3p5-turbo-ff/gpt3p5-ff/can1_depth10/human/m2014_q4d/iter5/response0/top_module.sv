module top_module (
	input clk,
	input in,
	output logic out
);

  reg FF_out;
  reg XOR_out;
  reg Q_delayed; // Added an additional signal to handle the delay

  D_FF flip_flop (
    .clk(clk),
    .D(XOR_out),
    .Q(Q_delayed)
  );

  assign out = FF_out;

  always_ff @(posedge clk) begin
    FF_out <= Q_delayed; // Assign FF_out with the delayed signal
  end

  XOR2 xor_gate (
    .A(in),
    .B(FF_out),
    .Z(XOR_out)
  );

endmodule
module D_FF (
  input clk,
  input D,
  output logic Q
);

  always_ff @(posedge clk) begin
    Q <= D;
  end

endmodule
module XOR2 (
  input A,
  input B,
  output logic Z
);

  assign Z = A ^ B;

endmodule
