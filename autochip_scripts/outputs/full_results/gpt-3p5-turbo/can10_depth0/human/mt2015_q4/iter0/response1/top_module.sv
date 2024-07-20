module A(
    input x,
    input y,
    output z
  );
  
  assign z = (x ^ y) & x;

endmodule
module B(
    input x,
    input y,
    output z
  );
  
  reg z;
  
  always @(x or y) begin
    case({x, y})
      {1'b0, 1'b0}: z <= 1'b1;
      {1'b1, 1'b0}: z <= 1'b0;
      {1'b0, 1'b1}: z <= 1'b0;
      {1'b1, 1'b1}: z <= 1'b1;
    endcase
  end
  
endmodule
module top_module(
  input x,
  input y,
  output z
);
  
  wire a1_out, a2_out, b1_out, b2_out;
  
  A a1(.x(x), .y(y), .z(a1_out));
  B b1(.x(x), .y(y), .z(b1_out));
  A a2(.x(x), .y(y), .z(a2_out));
  B b2(.x(x), .y(y), .z(b2_out));
  
  wire or_out, and_out;
  
  assign z = or_out ^ and_out;
  
  or or1(.a(a1_out), .b(b1_out), .z(or_out));
  and and1(.a(a2_out), .b(b2_out), .z(and_out));

endmodule
