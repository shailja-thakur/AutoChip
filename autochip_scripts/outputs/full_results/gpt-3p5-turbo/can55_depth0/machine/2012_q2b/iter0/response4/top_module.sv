module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
  
  // Outputs
  wire Y1;
  wire Y3;
  
  // Intermediate signals
  wire y1_bit;
  wire y2_bit;
  wire y3_bit;
  wire y5_bit;
  wire y6_bit;
  
  // Splitting the input vector
  assign y1_bit = y[0];
  assign y2_bit = y[1];
  assign y3_bit = y[2];
  assign y5_bit = y[4];
  assign y6_bit = y[5];
  
  // Y1 is true if both the first bit of the input vector y and the single bit input w are true
  assign Y1 = y1_bit & w;
  
  // Y3 is true if at least one of the second, third, fifth, and sixth bits of the input vector y is true and the single bit input w is false
  assign Y3 = (y2_bit | y3_bit | y5_bit | y6_bit) & (~w);
  
endmodule
