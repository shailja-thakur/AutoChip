module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

reg [98:0] both;
reg [99:1] any;
reg [99:0] different;

always @* begin
  for (int i = 0; i < 99; i = i + 1) begin
    both[i] = (in[i] & in[i+1]) ? 1'b1 : 1'b0;
    any[i+1] = (in[i] | in[i+1]) ? 1'b1 : 1'b0;
    different[i] = (in[i] != in[i+1]) ? 1'b1 : 1'b0;
  end
  any[0] = in[0];
end

assign out_both = both;
assign out_any = any;
assign out_different = different;

endmodule
