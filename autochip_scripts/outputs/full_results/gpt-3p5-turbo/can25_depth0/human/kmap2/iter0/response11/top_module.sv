module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);
  
  // Define internal wire signals
  wire w1, w2, w3, w4, w5, w6, w7;
  
  // Implement the logic gates
  xor_gate u1 (.a(a), .b(c), .out(w1));
  xor_gate u2 (.a(b), .b(d), .out(w2));
  xor_gate u3 (.a(c), .b(d), .out(w3));
  not_gate u4 (.a(u2), .out(w4));
  not_gate u5 (.a(w1), .out(w5));
  and_gate u6 (.a(w2), .b(w3), .out(w6));
  or_gate u7 (.a(w5), .b(w4), .out(w7));
  and_gate u8 (.a(w7), .b(w6), .out(out));
  
  // Define the logic gates modules
  
  // XOR gate
  module xor_gate (
    input a,
    input b,
    output out
  );
    assign out = a ^ b;
  endmodule
module not_gate (
    input a,
    output out
  );
    assign out = ~a;
  endmodule
module and_gate (
    input a,
    input b,
    output out
  );
    assign out = a & b;
  endmodule
module or_gate (
    input a,
    input b,
    output out
  );
    assign out = a | b;
  endmodule
