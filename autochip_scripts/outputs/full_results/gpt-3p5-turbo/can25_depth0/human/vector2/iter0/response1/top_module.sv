module top_module (
    input [31:0] in,
    output [31:0] out
);
  
  // Create a temporary variable to hold the reversed byte order
  wire [31:0] temp;
  
  // Reverse the byte order by swapping the bits
  assign temp[31:24] = in[7:0];
  assign temp[23:16] = in[15:8];
  assign temp[15:8] = in[23:16];
  assign temp[7:0] = in[31:24];
  
  // Assign the reversed byte order to the output
  assign out = temp;
  
endmodule
