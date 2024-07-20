module top_module(
  input [1:0] A,
  input [1:0] B,
  output reg z);

  always @(*) begin
    if (A[0] == B[0] && A[1] == B[1])
      z = 1;
    else
      z = 0;
  end

endmodule
