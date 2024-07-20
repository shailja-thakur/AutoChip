module top_module (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:1] out_any,
  output reg [99:0] out_different
);

always @* begin
  for (int i = 0; i < 99; i = i + 1) begin
    out_both[i] = (in[i] & in[i+1]) ? 1'b1 : 1'b0;
    out_any[i+1] = (in[i] | in[i+1]) ? 1'b1 : 1'b0;
    out_different[i] = (in[i] != in[i+1]) ? 1'b1 : 1'b0;
  end
  out_any[0] = 1'b0; // Set out_any[0] to 0 since there's no neighbor to the right
end

endmodule
