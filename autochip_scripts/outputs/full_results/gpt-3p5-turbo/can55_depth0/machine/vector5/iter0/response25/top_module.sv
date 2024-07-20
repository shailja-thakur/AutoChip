module top_module (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);

  // Wire declarations
  wire [24:0] vector1; // ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
  wire [24:0] vector2; // {5{a,b,c,d,e}}
  
  // Generate vector1
  assign vector1[24:20] = ~a;
  assign vector1[19:15] = ~b;
  assign vector1[14:10] = ~c;
  assign vector1[9:5] = ~d;
  assign vector1[4:0] = ~e;

  // Generate vector2
  assign vector2[24:20] = a; 
  assign vector2[19:15] = b;
  assign vector2[14:10] = c;
  assign vector2[9:5] = d;
  assign vector2[4:0] = e;

  // XOR gate
  assign out = vector1 ^ vector2;

endmodule
