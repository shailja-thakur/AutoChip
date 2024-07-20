module A(
  input x,
  input y,
  output z);

  // z = (x^y) & x;
  assign z = (x ^ y) & x;

endmodule
module B(
  input x,
  input y,
  output z);

  // Simulation waveform
  always @(x, y)
  begin
    case({x, y})
      2'b00: z = 1;
      2'b01, 2'b10, 2'b11: z = 0;
    endcase
  end

endmodule
module top_module(
  input x,
  input y,
  output z);

  // Instantiate A and B submodules
  wire a_out, b1_out, b2_out;

  A a1(.x(x), .y(y), .z(a_out));
  B b1(.x(x), .y(y), .z(b1_out));

  A a2(.x(x), .y(y), .z(b2_out));
  B b2(.x(x), .y(y), .z(z));

  // OR gate
  wire or_out;
  assign or_out = a_out | b1_out;

  // AND gate
  wire and_out;
  assign and_out = a2_out & b2_out;

  // XOR gate
  assign z = or_out ^ and_out;

endmodule
