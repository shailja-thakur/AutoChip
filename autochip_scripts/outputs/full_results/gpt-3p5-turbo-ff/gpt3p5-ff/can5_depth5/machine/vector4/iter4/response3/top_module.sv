module top_module (
  input [7:0] in,
  output [31:0] out
);

  assign out[31:8] = {in, in, in, in, in, in, in, in};
  assign out[7:0] = in;

endmodule
