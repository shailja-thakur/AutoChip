module top_module (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);

  reg [3:0] temp_diff;
  wire [2:0] temp_both;
  wire [3:1] temp_any;

  assign temp_both[0] = in[0] & in[3];
  assign temp_both[1] = in[1] & in[0];
  assign temp_both[2] = in[2] & in[1];

  assign temp_any[2:0] = in[1:3];
  assign temp_any[3] = in[0];
  assign temp_any[4:6] = in[0:2];
  assign temp_any[7] = in[3];

  assign temp_diff[0] = in[0] ^ in[3];
  assign temp_diff[1] = in[1] ^ in[0];
  assign temp_diff[2] = in[2] ^ in[1];
  assign temp_diff[3] = in[3] ^ in[2];

  assign out_both = temp_both;
  assign out_any = temp_any;
  assign out_different = temp_diff;
endmodule
