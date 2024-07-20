module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  // Overflow detection
  wire add_overflow;
  wire sub_overflow;
  
  assign add_overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
  assign sub_overflow = (a[7] & ~b[7] & ~s[7]) | (~a[7] & b[7] & s[7]);
  
  assign overflow = add_overflow | sub_overflow;
  
  // Addition
  assign s = a + b;
  
endmodule
