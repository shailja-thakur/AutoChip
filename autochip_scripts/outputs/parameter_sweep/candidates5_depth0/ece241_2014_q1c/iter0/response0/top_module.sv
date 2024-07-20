module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  reg [8:0] sum; // 9-bit register to hold addition result, including carry

  always @(*) begin
    sum = a + b; // compute sum
    s = sum[7:0]; // assign sum[7:0] to output s

    if (sum[8] == 1) // check if MSB of sum is 1
      overflow = 1; // set overflow to 1 if overflow occurred
    else
      overflow = 0; // set overflow to 0 if no overflow occurred
  end
  
endmodule
