module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // Calculate the starting index of the 4-bit block based on the selection vector
  reg [9:0] start_index;
  always @* begin
    start_index = sel << 6;
  end

  // Extract the 4-bit block from the input vector based on the starting index
  wire [3:0] block;
  assign block = in[start_index +: 4];

  // Assign the extracted block to the output
  assign out = block;

endmodule
