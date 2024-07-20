module top_module (
  input [7:0] input1,
  output reg p1y,
  input [7:0] input2,
  output reg p2y
);

  always @(input1) begin
    p1y = ~(input1[0] & input1[1] & input1[2] & input1[3]);
  end

  always @(input2) begin
    p2y = ~(input2[0] & input2[1] & input2[2] & input2[3]);
  end

endmodule
