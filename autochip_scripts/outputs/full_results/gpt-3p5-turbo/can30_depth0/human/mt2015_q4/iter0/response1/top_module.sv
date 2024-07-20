module A(
  input x,
  input y,
  output z);
  
  assign z = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z);
  
  reg z;
  always @(x or y)
  begin
    case ({x, y})
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
  output z);

  wire z1, z2;
  
  A a1 (.x(x), .y(y), .z(z1));
  A a2 (.x(x), .y(y), .z(z2));
  B b1 (.x(x), .y(y), .z(z1));
  B b2 (.x(x), .y(y), .z(z2));

  wire or_out;
  wire and_out;
  
  assign or_out = z1 | z2;
  assign and_out = z1 & z2;
  
  assign z = or_out ^ and_out;

endmodule
