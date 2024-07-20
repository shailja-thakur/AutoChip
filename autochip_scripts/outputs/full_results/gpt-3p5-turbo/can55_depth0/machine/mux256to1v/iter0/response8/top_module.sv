module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [9:0] index;
  reg [3:0] out_reg;

  always @(*) begin
    index = sel * 4;  // Calculate starting index of 4-bit block in the input vector
    out_reg = in[index +: 4];  // Extract 4-bit block from input vector
  end

  assign out = out_reg;  // Assign extracted block to output vector

endmodule
