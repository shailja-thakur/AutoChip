module top_module (
	input [31:0] in,
	output [31:0] out
);

  // Wire Declarations
  wire [7:0] in_byte [3:0];
  wire [7:0] out_byte [3:0];
  
  // Assign bytes
  assign in_byte[0] = in[7:0];
  assign in_byte[1] = in[15:8];
  assign in_byte[2] = in[23:16];
  assign in_byte[3] = in[31:24];
  
  // Reverse the byte order
  assign out_byte[0] = in_byte[3];
  assign out_byte[1] = in_byte[2];
  assign out_byte[2] = in_byte[1];
  assign out_byte[3] = in_byte[0];
  
  // Concatenate the bytes to form the output
  assign out = {out_byte[3], out_byte[2], out_byte[1], out_byte[0]};
  
endmodule
