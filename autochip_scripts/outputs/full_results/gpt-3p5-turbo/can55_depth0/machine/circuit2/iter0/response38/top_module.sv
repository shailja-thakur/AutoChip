module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

  wire temp;
  assign temp = a ^ b ^ c ^ d;
  assign q = ~temp;

endmodule
