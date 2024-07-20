module top_module (
   input [99:0] in,
   output [98:0] out_both,
   output [99:1] out_any,
   output [99:0] out_different
);
   
   // Generate out_both by performing a bit-wise AND operation
   assign out_both = in[98:0] & in[99:1];
   
   // Generate out_any by performing a bit-wise OR operation
   assign out_any = in[99:0] | in[99:1];
   
   // Generate out_different by performing a bit-wise XOR operation
   assign out_different = {in[0] ^ in[99], in[99:1]};
   
endmodule
