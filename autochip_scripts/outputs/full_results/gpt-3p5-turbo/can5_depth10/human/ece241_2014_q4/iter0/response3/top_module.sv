module top_module (
	input clk,
	input x,
	output z
);

  reg d1, d2, d3;
  wire q1, q2, q3;
  wire nq1, nq2, nq3;
  
  xor gate1 (q1, x, d1);
  and gate2 (q2, x, d2);
  or gate3 (q3, x, d3);
  
  d_flip_flop dff1 (.clk(clk), .d(q1), .q(q1), .nq(nq1));
  d_flip_flop dff2 (.clk(clk), .d(q2), .q(q2), .nq(nq2));
  d_flip_flop dff3 (.clk(clk), .d(q3), .q(q3), .nq(nq3));
  
  xnor gate4 (z, q1, q2, q3);
  
endmodule
module xor (
  output out,
  input in1,
  input in2
);
  assign out = in1 ^ in2;
endmodule
module and (
  output out,
  input in1,
  input in2
);
  assign out = in1 & in2;
endmodule
module or (
  output out,
  input in1,
  input in2
);
  assign out = in1 | in2;
endmodule
module d_flip_flop (
  input clk,
  input d,
  output q,
  output nq
);
  reg q, nq;
  
  always @(posedge clk)
  begin
    q <= d;
    nq <= ~d;
  end
  
endmodule
module xnor (
  output out,
  input in1,
  input in2,
  input in3
);
  reg tmp1, tmp2;
  
  xor g1 (tmp1, in1, in2);
  xor g2 (tmp2, tmp1, in3);
  
  assign out = tmp2;
  
endmodule
