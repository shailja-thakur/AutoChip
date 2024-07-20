module top_module(
  input wire p1a, 
  input wire p1b, 
  input wire p1c, 
  input wire p1d, 
  output wire p1y, 
  input wire p2a, 
  input wire p2b, 
  input wire p2c, 
  input wire p2d, 
  output wire p2y
);
  wire and_result_p1;
  wire and_result_p2;

  and_gate_4x1 and1 (
    .a1(p1a),
    .a2(p1b),
    .a3(p1c),
    .a4(p1d),
    .y(and_result_p1)
  );

  and_gate_4x1 and2 (
    .a1(p2a),
    .a2(p2b),
    .a3(p2c),
    .a4(p2d),
    .y(and_result_p2)
  );

  inv_gate inv1 (
    .a(and_result_p1),
    .y(p1y)
  );

  inv_gate inv2 (
    .a(and_result_p2),
    .y(p2y)
  );
  
  // AND gate module
  module and_gate_4x1 (
    input wire a1,
    input wire a2,
    input wire a3,
    input wire a4,
    output wire y
  );
    assign y = a1 & a2 & a3 & a4;
  endmodule
module inv_gate (
    input wire a,
    output wire y
  );
    assign y = ~a;
  endmodule
