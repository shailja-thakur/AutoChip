module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

wire [98:0] in_shifted;
wire [99:0] in_wrapped;

assign in_shifted = {in[98:0], 1'b0};
assign in_wrapped = {in[99], in};

assign out_both = in[98:0] & in_shifted;
assign out_any = in_wrapped[1:99] | in_wrapped[0:98];
assign out_different = in[98:0] != in_shifted;

endmodule
