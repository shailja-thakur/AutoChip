module top_module (
  input [31:0] in,
  output [31:0] out
);
   reg [31:0] reverse;
   always @* begin
      for (int i = 0; i < 32; i = i + 1) begin
         reverse[i] = in[31 - i];
      end
   end
   assign out = reverse;
endmodule
