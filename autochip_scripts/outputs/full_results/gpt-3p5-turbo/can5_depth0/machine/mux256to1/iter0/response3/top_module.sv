module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

  wire [255:0] selected_bit;
  wire [7:0] zero_vector;

  assign zero_vector = 8'b00000000;

  assign selected_bit = in[sel];

  assign out = selected_bit[0];

endmodule
