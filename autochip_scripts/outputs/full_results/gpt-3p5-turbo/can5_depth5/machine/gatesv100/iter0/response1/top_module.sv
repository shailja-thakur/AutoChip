module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  
  wire [98:0] shifted_in;
  wire [99:0] in_extended;

  assign shifted_in = {in[98:0], 1'b0};
  assign in_extended = {in[0], in};

  assign out_both = in[98:0] & shifted_in;
  assign out_any = in[99:0] | shifted_in;
  assign out_different = {in[0] ^ shifted_in[99], in_extended ^ shifted_in};
  
endmodule
