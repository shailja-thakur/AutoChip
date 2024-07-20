module top_module (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);

  reg [24:0] not_vec; // vector to store the bitwise negation of the input signals
  reg [24:0] and_vec; // vector to store the bitwise and of the input signals
  reg [24:0] xor_vec; // vector to store the bitwise xor of not_vec and and_vec
  
  // assign values to not_vec
  assign not_vec = { {5{~a}}, {5{~b}}, {5{~c}}, {5{~d}}, {5{~e}} };
  
  // assign values to and_vec
  assign and_vec = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

  // assign values to xor_vec
  assign xor_vec = not_vec ^ and_vec;
  
  // assign output
  assign out = xor_vec;
  
endmodule
