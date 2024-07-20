module A (
  input x,
  input y,
  output z
);
  reg z;
  
  always @(*)
  begin
    z = (x^y) & x;
  end
  
endmodule
module B (
  input x,
  input y,
  output z
);
  reg z;
  
  always @(*)
  begin
    case({x,y})
      2'b00: z = 1;
      2'b01: z = 0;
      2'b10: z = 0;
      2'b11: z = 1;
    endcase
  end
  
endmodule
module top_module(
  input x,
  input y,
  output z
);
  wire a_out, b_out;
  reg z;
  
  A A1(
    .x(x),
    .y(y),
    .z(a_out)
  );
  
  B B1(
    .x(x),
    .y(y),
    .z(b_out)
  );
  
  A A2(
    .x(x),
    .y(y),
    .z(a_out)
  );
  
  B B2(
    .x(x),
    .y(y),
    .z(b_out)
  );
  
  or or_gate(
    .a(a_out),
    .b(b_out),
    .z(z)
  );
  
  and and_gate(
    .a(a_out),
    .b(b_out),
    .z(z)
  );
  
  xor xor_gate(
    .a(z),
    .b(z),
    .z(z)
  );
  
endmodule
