module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // Define the internal signals
  wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;
  
  // Generate the intermediate signals
  assign w1 = (a & b & ~c & d);  // 2
  assign w2 = (~a & ~b & c & ~d);  // 7
  assign w3 = (~a & ~b & ~c & ~d);  // 15
  assign w4 = (~a & ~b & ~c & ~d);  // 0
  assign w5 = (a & b & ~c & ~d);  // 1
  assign w6 = (~a & ~b & c & ~d);  // 4
  assign w7 = (~a & ~b & c & d);  // 5
  assign w8 = (~a & ~b & c & d);  // 6
  assign w9 = (~a & b & ~c & d);  // 9
  assign w10 = (~a & b & ~c & d);  // 10
  assign w11 = (~a & b & c & ~d);  // 13
  assign w12 = (~a & b & c & ~d);  // 14
  
  // Generate the outputs
  assign out_sop = w1 | w2 | w3;
  assign out_pos = w4 & w5 & w6 & w7 & w8 & w9 & w10 & w11 & w12;

endmodule
