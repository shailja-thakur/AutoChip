module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // out_both logic
  assign out_both[0] = in[0] & in[99];
  generate
    genvar i;
    for (i = 1; i < 99; i = i + 1) begin : both_block
      assign out_both[i] = in[i] & in[i-1];
    end
  endgenerate

  // out_any logic
  assign out_any[99] = in[99] | in[0];
  generate
    genvar j;
    for (j = 1; j < 99; j = j + 1) begin : any_block
      assign out_any[j] = in[j] | in[j+1];
    end
  endgenerate

  // out_different logic
  assign out_different[0] = (in[0] != in[99]);
  generate
    genvar k;
    for (k = 1; k < 100; k = k + 1) begin : different_block
      assign out_different[k] = (in[k] != in[k-1]);
    end
  endgenerate

endmodule
