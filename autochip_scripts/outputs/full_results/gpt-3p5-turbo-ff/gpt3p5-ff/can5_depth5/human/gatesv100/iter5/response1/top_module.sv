module top_module (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:1] out_any,
  output reg [99:0] out_different
);

always @* begin
  for (int i = 0; i < 98; i = i + 1) begin
    out_both[i] = (in[i] & in[i+1]) ? 1'b1 : 1'b0;
    out_any[i+1] = (in[i] | in[i+1]) ? 1'b1 : 1'b0;
    out_different[i] = (in[i] != in[i+1]) ? 1'b1 : 1'b0;
  end
  out_both[98] = (in[98] & in[99]) ? 1'b1 : 1'b0;
  out_any[99] = (in[99] | in[0]) ? 1'b1 : 1'b0;
  out_different[99] = (in[99] != in[98]) ? 1'b1 : 1'b0;
end

endmodule
