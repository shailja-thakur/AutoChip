module top_module (
  input [31:0] in,
  output [31:0] out
);

  // Simply reversing the byte order
  assign out = {in[24:31], in[16:23], in[8:15], in[0:7]};

endmodule
