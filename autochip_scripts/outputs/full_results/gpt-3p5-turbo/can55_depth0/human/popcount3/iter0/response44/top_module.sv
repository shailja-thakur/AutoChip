module top_module (
  input [2:0] in,
  output [1:0] out
);
  
  wire [1:0] temp;
  
  assign temp[0] = in[0] & in[1];
  assign temp[1] = in[0] & in[2] | in[1] & in[2];
  
  assign out = temp;
  
endmodule
