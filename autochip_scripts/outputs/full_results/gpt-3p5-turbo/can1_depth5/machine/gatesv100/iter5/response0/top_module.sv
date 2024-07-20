module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output reg [99:0] out_any,
    output [99:0] out_different
);

   assign out_both = in[98:0] & in[99:1];
   always @(*) begin
       out_any = in | (in << 1'b1);
   end
   assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]};

endmodule
