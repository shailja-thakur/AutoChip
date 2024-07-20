module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
  );
  
  // Wire declarations
  wire w1, w2;
  
  // Assignments to wires
  assign w1 = a & b;
  assign w2 = c & d;
  
  // Output assignments
  assign out = w1 | w2;
  assign out_n = ~out;
  
endmodule
