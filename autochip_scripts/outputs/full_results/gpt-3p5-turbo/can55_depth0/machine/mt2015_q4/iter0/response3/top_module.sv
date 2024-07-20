module top_module(
    input x,
    input y,
    output z);

  wire a, b;
  assign a = x;
  assign b = y;
  
  // First gate
  and gate1(
    .a(a),
    .b(b),
    .out(a1)
  );
  
  // Second gate
  and gate2(
    .a(b),
    .b(a),
    .out(b1)
  );
  
  // Third gate
  and gate3(
    .a(a1),
    .b(b1),
    .out(z)
  );
  
endmodule
