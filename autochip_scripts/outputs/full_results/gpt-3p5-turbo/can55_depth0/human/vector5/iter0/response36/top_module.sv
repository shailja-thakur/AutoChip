module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
  wire [4:0] a_n;
  wire [4:0] b_n;
  wire [4:0] c_n;
  wire [4:0] d_n;
  wire [4:0] e_n;
  
  assign a_n = ~a;
  assign b_n = ~b;
  assign c_n = ~c;
  assign d_n = ~d;
  assign e_n = ~e;
  
  assign out[24] = a_n[4] ^ a[0];
  assign out[23] = a_n[4] ^ b;
  assign out[22] = a_n[4] ^ c;
  assign out[21] = a_n[4] ^ d;
  assign out[20] = a_n[4] ^ e;
  assign out[19] = b_n[4] ^ a[0];
  assign out[18] = b_n[4] ^ b;
  assign out[17] = b_n[4] ^ c;
  assign out[16] = b_n[4] ^ d;
  assign out[15] = b_n[4] ^ e;
  assign out[14] = c_n[4] ^ a[0];
  assign out[13] = c_n[4] ^ b;
  assign out[12] = c_n[4] ^ c;
  assign out[11] = c_n[4] ^ d;
  assign out[10] = c_n[4] ^ e;
  assign out[9] = d_n[4] ^ a[0];
  assign out[8] = d_n[4] ^ b;
  assign out[7] = d_n[4] ^ c;
  assign out[6] = d_n[4] ^ d;
  assign out[5] = d_n[4] ^ e;
  assign out[4] = e_n[4] ^ a[0];
  assign out[3] = e_n[4] ^ b;
  assign out[2] = e_n[4] ^ c;
  assign out[1] = e_n[4] ^ d;
  assign out[0] = e_n[4] ^ e;
  
endmodule
