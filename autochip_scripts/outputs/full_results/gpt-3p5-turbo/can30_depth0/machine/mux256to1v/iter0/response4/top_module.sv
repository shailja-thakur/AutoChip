module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [9:0] index;
  
  always @(*) begin
    index = sel << 6;
  end
  
  assign out = in[index +: 4];
  
endmodule
