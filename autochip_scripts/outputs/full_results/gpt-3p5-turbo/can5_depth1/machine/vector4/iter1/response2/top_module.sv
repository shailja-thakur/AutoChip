module top_module (
  input [7:0] in,
  output [31:0] out
);

  generate
    genvar i;
    for (i = 0; i < 24; i = i + 1) begin : replication
      assign out[i*8 +: 8] = in;
    end
  endgenerate

  assign out[192:223] = in;

endmodule
