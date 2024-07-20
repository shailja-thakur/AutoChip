module top_module(
    input x,
    input y,
    output z
);

  wire a, b;
  
  and u1(x, y, a);
  or u2(x, y, b);
  or u3(a, b, z);

endmodule
