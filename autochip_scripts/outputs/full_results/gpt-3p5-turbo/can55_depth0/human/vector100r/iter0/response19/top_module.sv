module top_module (
  input [99:0] in,
  output reg [99:0] out
);

  // Variable for storing the reversed input
  reg [99:0] reversed_in;

  // Reversing the input vector
  integer i;
  always @(*) begin
    for (i = 0; i <= 99; i = i + 1) begin
      reversed_in[i] = in[99 - i];
    end
  end

  // Assigning the reversed output
  always @(posedge clk) begin
    out <= reversed_in;
  end

endmodule
