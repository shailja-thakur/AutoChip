module top_module (
  input [7:0] in,
  output parity
);

  wire [7:0] xor_result;
  reg parity_bit;

  assign xor_result = ^in;

  assign parity = xor_result[0] ^ xor_result[1] ^ xor_result[2] ^ xor_result[3] ^ xor_result[4] ^ xor_result[5] ^ xor_result[6] ^ xor_result[7] ^ parity_bit;

  always @(in) begin
    parity_bit <= ^in;
  end

endmodule
