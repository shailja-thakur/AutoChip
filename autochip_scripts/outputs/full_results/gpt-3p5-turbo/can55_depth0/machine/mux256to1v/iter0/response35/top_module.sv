module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // parameter to define the size of the block
  parameter BLOCK_SIZE = 4;
  
  // calculate the starting index of the 4-bit block
  reg [9:0] start_index;
  always @* begin
    start_index = sel * BLOCK_SIZE;
  end
  
  // assign the 4-bit block from the input vector to the output vector
  assign out = in[start_index + BLOCK_SIZE - 1 : start_index];
  
endmodule
