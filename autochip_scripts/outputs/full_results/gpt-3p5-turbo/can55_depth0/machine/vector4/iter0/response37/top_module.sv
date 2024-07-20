module top_module (
	input [7:0] in,
	output [31:0] out
);
  wire [7:0] replicated_in [23:0];
  
  assign replicated_in[0] = in;
  assign replicated_in[1] = in;
  assign replicated_in[2] = in;
  assign replicated_in[3] = in;
  assign replicated_in[4] = in;
  assign replicated_in[5] = in;
  assign replicated_in[6] = in;
  assign replicated_in[7] = in;
  assign replicated_in[8] = in;
  assign replicated_in[9] = in;
  assign replicated_in[10] = in;
  assign replicated_in[11] = in;
  assign replicated_in[12] = in;
  assign replicated_in[13] = in;
  assign replicated_in[14] = in;
  assign replicated_in[15] = in;
  assign replicated_in[16] = in;
  assign replicated_in[17] = in;
  assign replicated_in[18] = in;
  assign replicated_in[19] = in;
  assign replicated_in[20] = in;
  assign replicated_in[21] = in;
  assign replicated_in[22] = in;
  assign replicated_in[23] = in;
  
  assign out = {replicated_in, in};
  
endmodule
