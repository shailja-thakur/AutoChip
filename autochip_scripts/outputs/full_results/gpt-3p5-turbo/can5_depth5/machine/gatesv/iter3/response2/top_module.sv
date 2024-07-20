module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);

  wire [3:0] in3_1 = in[3:1];
  wire in0 = in[0];
  
  assign out_both = in[2:0] & in3_1;
  assign out_any = in[2:0] | in3_1;
  assign out_different = in ^ {in3_1, in0};

endmodule
