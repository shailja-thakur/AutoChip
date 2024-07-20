module top_module(
    input wire p1a, 
    input wire p1b, 
    input wire p1c, 
    input wire p1d,
    input wire p1e,
    input wire p1f,
    output wire p1y, 
    input wire p2a, 
    input wire p2b, 
    input wire p2c, 
    input wire p2d, 
    output wire p2y
);
  
  wire w1, w2, w3, w4;
  
  assign w1 = p1a & p1b & p1c;
  assign w2 = p1d & p1e & p1f;
  assign p1y = w1 | w2;
  
  assign w3 = p2a & p2b;
  assign w4 = p2c & p2d;
  assign p2y = w3 | w4;
  
endmodule
