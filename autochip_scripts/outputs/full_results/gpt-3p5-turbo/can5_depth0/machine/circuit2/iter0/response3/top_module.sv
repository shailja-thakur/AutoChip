module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

  wire wire1;
  wire wire2;
  wire wire3;
  
  assign wire1 = a ^ b;
  assign wire2 = wire1 ^ c;
  assign wire3 = wire2 ^ d;
  
  assign q = ~wire3;
  
endmodule
