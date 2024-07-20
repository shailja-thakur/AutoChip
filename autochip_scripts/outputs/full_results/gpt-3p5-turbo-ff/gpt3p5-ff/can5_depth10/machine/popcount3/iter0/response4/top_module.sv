module top (
  input [2:0] in,
  output [1:0] out
);

  // Logic to calculate the output
  always @(*) begin
    out[1] = in[2] + in[1] + in[0]; // Calculate the most significant bit of the result
    out[0] = in[1] + in[0]; // Calculate the least significant bit of the result
  end

endmodule
