module B(
  input x,
  input y,
  output z
  );

  reg [1:0] state;
  reg z_reg;

  always @(x, y)
    case (state)
      0: begin
           z = 1'b1;
           state = 1;
         end
      1: begin
           z = 1'b1;
           state = 0;
         end
      default: begin
                 z = 1'b0;
                 state = 0;
               end
    endcase
  
endmodule
module A(
  input x,
  input y,
  output z
  );

  wire a;
  wire b;
  
  xor (a, x, y);
  and (b, a, x);
  
  assign z = b;

endmodule
module top_module(
  input x,
  input y,
  output z
  );
  wire a_out1;
  wire a_out2;
  wire b_out1;
  wire b_out2;
  wire or_out;
  wire and_out;

  A A1(.x(x), .y(y), .z(a_out1));
  A A2(.x(x), .y(y), .z(a_out2));
  B B1(.x(x), .y(y), .z(b_out1));
  B B2(.x(x), .y(y), .z(b_out2));

  or (or_out, a_out1, b_out1);
  and (and_out, a_out2, b_out2);
  xor (z, or_out, and_out);
  
endmodule
