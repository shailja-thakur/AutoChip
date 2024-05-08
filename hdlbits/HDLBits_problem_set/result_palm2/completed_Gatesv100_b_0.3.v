module top_module(
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [99:0] out_both;
  reg [99:1] out_any;
  reg [99:0] out_different;

  always @(posedge clk) begin
    out_both <= in[99:0] & in[98:1];
    out_any <= in[99:1] | in[98:0];
    out_different <= in[99:0] ^ in[98:1];
  end

endmodule