module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [3:0] block_start_index;
  reg [1023:0] block;

  always @(*) begin
    block_start_index = sel * 4;
    block = in[block_start_index +: 4];
  end

  assign out = block;

endmodule
