module top_module (
  input [7:0] in,
  output parity
);

wire [7:0] inverted_in;
wire parity_bit;

assign inverted_in = ~in;
assign parity_bit = inverted_in[0] ^ inverted_in[1] ^ inverted_in[2] ^ inverted_in[3] ^ inverted_in[4] ^ inverted_in[5] ^ inverted_in[6] ^ inverted_in[7];

assign parity = ~parity_bit;

endmodule
