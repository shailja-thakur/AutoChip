module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

   wire [3:0] xor_out;
   wire [3:0] inv_out;

   assign xor_out = a ^ b ^ c ^ d;
   assign inv_out = ~xor_out;
   assign q = inv_out[0];

endmodule
