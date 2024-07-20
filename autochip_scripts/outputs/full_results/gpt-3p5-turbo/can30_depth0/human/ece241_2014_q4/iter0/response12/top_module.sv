module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign z = ~(q1 ^ q2 ^ q3);

xor_gate xor1 (x, q1, d1);
and_gate and1 (x, ~q2, d2);
or_gate or1 (x, ~q3, d3);

always @(posedge clk)
begin
    d1 <= q1;
    d2 <= q2;
    d3 <= q3;
end

endmodule
module xor_gate (
	input a,
	input b,
	output c
);
    assign c = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output c
);
    assign c = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output c
);
    assign c = a | b;
endmodule
