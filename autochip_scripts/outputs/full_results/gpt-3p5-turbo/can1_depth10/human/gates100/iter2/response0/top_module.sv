module top_module (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  assign out_and = &in;
  assign out_or = |in;

  assign out_xor = in[0];

  genvar i;
  generate
    for (i = 1; i < 100; i = i + 1) begin : loop
      assign out_xor = out_xor ^ in[i];
    end
  endgenerate

endmodule
