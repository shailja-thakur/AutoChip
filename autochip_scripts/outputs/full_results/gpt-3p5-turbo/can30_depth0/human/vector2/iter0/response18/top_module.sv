module top_module (
  input [31:0] in,
  output [31:0] out
);
  
  // This module performs byte order reversal of a 32-bit vector
  // by swapping the position of the bytes
  
  // Declare internal wire and reg for temporary storage
  wire [7:0] byte0, byte1, byte2, byte3;
  reg [31:0] temp;
  
  // Extract the individual bytes from the input vector
  assign byte0 = in[7:0];
  assign byte1 = in[15:8];
  assign byte2 = in[23:16];
  assign byte3 = in[31:24];
  
  // Reverse the byte order
  always @* begin
    temp = {byte3, byte2, byte1, byte0};
  end
  
  // Assign the reversed vector to the output
  assign out = temp;
  
endmodule
