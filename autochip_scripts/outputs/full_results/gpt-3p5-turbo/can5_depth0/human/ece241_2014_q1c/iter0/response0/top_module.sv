module top_module (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

  always @(*) begin
    // Perform two's complement addition
    {overflow, s} = a + b;

    // Check for overflow
    if (a[7] == b[7] && s[7] != a[7]) begin
      overflow = 1;
    end else begin
      overflow = 0;
    end
  end

endmodule
