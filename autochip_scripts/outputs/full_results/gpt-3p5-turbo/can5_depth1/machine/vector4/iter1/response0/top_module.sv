module top_module (
  input [7:0] in,
  output [31:0] out
);
  wire [31:0] output_wire;
  
  generate
    genvar i;
    for (i = 0; i < 24; i = i + 1) begin: replication
      assign output_wire[i*8 +: 8] = in;
    end
  endgenerate
  
  assign output_wire[192 +: 8] = in;
  assign out = output_wire;
endmodule
