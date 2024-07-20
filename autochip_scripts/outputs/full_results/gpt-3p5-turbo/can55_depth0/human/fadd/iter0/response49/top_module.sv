module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  wire w1, w2, w3; // Intermediate wires
  
  // Generate the sum and individual carry-out bits
  
  xor_gate xg1(.a(a), .b(b), .z(w1));     // XOR gate for a and b
  xor_gate xg2(.a(w1), .b(cin), .z(sum)); // XOR gate for the previous result and cin
  
  and_gate ag1(.a(a), .b(b), .z(w2));     // AND gate for a and b
  and_gate ag2(.a(w1), .b(cin), .z(w3));  // AND gate for the previous result and cin
 
  or_gate og1(.a(w2), .b(w3), .z(cout));   // OR gate for the carry-out bits

endmodule
