module A (
  input x,
  input y,
  output z
);
  assign z = (x ^ y) & x;
endmodule
module B (
  input x,
  input y,
  output z
);
  reg z;
  always @(x, y)
  begin
    case({x, y})
      2'b00: z = 1;
      2'b11: z = 1;
      default: z = 0;
    endcase
  end
endmodule
module top_module(
  input x,
  input y,
  output z
);
  wire a_out_0, a_out_1, b_out_0, b_out_1;

  A a0 (.x(x), .y(y), .z(a_out_0));
  A a1 (.x(x), .y(y), .z(a_out_1));
  B b0 (.x(x), .y(y), .z(b_out_0));
  B b1 (.x(x), .y(y), .z(b_out_1));

  wire or_out, and_out;
  or or_gate (.a(a_out_0), .b(b_out_0), .z(or_out));
  and and_gate (.a(a_out_1), .b(b_out_1), .z(and_out));

  xor xor_gate (.a(or_out), .b(and_out), .z(z));
endmodule
