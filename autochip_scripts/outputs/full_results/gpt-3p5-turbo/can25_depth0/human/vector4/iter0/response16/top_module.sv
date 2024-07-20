module top_module (
    input [7:0] in,
    output [31:0] out
);
  wire [7:0] sign_bit;

  assign sign_bit = in[7];
  assign out = {24{sign_bit}, in};

endmodule
