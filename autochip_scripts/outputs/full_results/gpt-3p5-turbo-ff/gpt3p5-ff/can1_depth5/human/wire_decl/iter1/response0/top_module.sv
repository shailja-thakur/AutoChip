module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );

  wire intermediate1;
  wire intermediate2;

  and_gate gate1 (intermediate1, a, b);
  and_gate gate2 (intermediate2, c, d);
  or_gate gate3 (out, intermediate1, intermediate2);
  not_gate gate4 (out_n, out);

endmodule
module and_gate (output reg o, input a, input b);
  always @(*) begin
    o = a & b;
  end
endmodule
module or_gate (output reg o, input a, input b);
  always @(*) begin
    o = a | b;
  end
endmodule
module not_gate (output reg o, input i);
  always @(*) begin
    o = ~i;
  end
endmodule
