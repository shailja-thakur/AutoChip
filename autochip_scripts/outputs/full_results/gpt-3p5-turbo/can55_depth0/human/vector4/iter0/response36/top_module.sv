module top_module (
  input [7:0] in,
  output [31:0] out
);

reg [7:0] sign_extended;
assign out = {24{in[7]}, in};


endmodule
