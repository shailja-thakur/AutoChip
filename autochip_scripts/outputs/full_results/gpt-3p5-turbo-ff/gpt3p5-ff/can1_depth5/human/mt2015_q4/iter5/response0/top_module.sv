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

  assign z = ~(x & y);

endmodule
module top_module(
  input x,
  input y,
  output z);

  wire a1_out, a2_out, b1_out, b2_out;
  wire or_out, and_out;

  A a1 (.x(x), .y(y), .z(a1_out));
  B b1 (.x(x), .y(y), .z(b1_out));

  A a2 (.x(x), .y(y), .z(a2_out));
  B b2 (.x(x), .y(y), .z(b2_out));

  assign or_out = a1_out | b1_out;
  assign and_out = a2_out & b2_out;

  assign z = or_out ^ and_out;

endmodule
module top_module_tb();
  reg x, y;
  wire z;

  top_module dut (
    .x(x),
    .y(y),
    .z(z)
  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module_tb);

    x = 0;
    y = 0;
    #5;
    x = 0;
    y = 0;
    #5;
    x = 0;
    y = 0;
    #5;
    x = 0;
    y = 0;
    #5;
    x = 0;
    y = 0;
    #5;
    x = 1;
    y = 0;
    #5;
    x = 1;
    y = 0;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 1;
    y = 1;
    #5;
    x = 1;
    y = 1;
    #5;
    x = 0;
    y = 0;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 1;
    y = 1;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 0;
    y = 1;
    #5;
    x = 1;
    y = 0;
    #5;

    $finish;
  end

endmodule
