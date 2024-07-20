module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

  // Instantiate XNOR gate
  wire xnor_out;
  xnor_gate u_xnor (
    .in1(in1),
    .in2(in2),
    .out(xnor_out)
  );
  
  // Instantiate XOR gate
  xor_gate u_xor (
    .in1(xnor_out),
    .in2(in3),
    .out(out)
  );
  
endmodule
module xnor_gate (
	input in1,
	input in2,
	output reg out
);

	always @(*) begin
		out = ~(in1 ^ in2);
	end
  
endmodule
module xor_gate (
	input in1,
	input in2,
	output reg out
);

	always @(*) begin
		out = in1 ^ in2;
	end
  
endmodule
