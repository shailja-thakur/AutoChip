module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  always @(*)
  begin
    // Calculate the starting index of the selected block
    integer start_index = sel * 4;
    
    // Extract the 4-bit block from the input vector
    assign out = in[start_index +: 4];
  end

endmodule
