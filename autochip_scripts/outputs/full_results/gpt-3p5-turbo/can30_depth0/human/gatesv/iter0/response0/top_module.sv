module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);
  wire both0, both1, both2;
  wire any1, any2, any3;
  wire diff0, diff1, diff2, diff3;
  
  assign both0 = in[0] & in[3];
  assign both1 = in[1] & in[0];
  assign both2 = in[2] & in[1];
  
  assign any1 = in[2] | in[1];
  assign any2 = in[3] | in[2];
  assign any3 = in[0] | in[3];
  
  assign diff0 = in[0] !== in[3];
  assign diff1 = in[1] !== in[0];
  assign diff2 = in[2] !== in[1];
  assign diff3 = in[3] !== in[2];
  
  assign out_both = {both2, both1, both0};
  assign out_any = {any3, any2, any1};
  assign out_different = {diff3, diff2, diff1, diff0};
  
endmodule
