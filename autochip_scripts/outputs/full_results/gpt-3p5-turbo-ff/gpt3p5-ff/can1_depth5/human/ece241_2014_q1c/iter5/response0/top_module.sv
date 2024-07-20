module top_module (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

  wire [8:0] sum;

  always @(*) begin
    sum = a + b;
    if (sum > 127 || sum < -128) begin
      overflow = 1;
    end
    else begin
      overflow = 0;
    end
    s = sum[7:0];
  end

endmodule
