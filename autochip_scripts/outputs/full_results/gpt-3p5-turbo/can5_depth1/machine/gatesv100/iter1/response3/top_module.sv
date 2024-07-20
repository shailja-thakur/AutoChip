module top_module (
   input [99:0] in,
   output reg [98:0] out_both,
   output reg [99:1] out_any,
   output reg [99:0] out_different
);

   always @(*)
   begin
      out_both = in[99:1] & in[98:0];
      out_any = in | (in << 1);
      out_different[0] = in[0] ^ in[99]; // fix for first bit of out_different

      // loop to compute remaining bits of out_different
      for (int i = 1; i < 100; i++)
         out_different[i] = in[i] ^ in[i-1];
   end

endmodule
