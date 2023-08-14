module top_module (
  input wire [99:0] a,
  input wire [99:0] b,
  input wire cin,
  output wire cout,
  output wire [99:0] sum
);

  wire [99:0] carry;

  always @(posedge clk) begin
    carry <= cin;
    for (int i = 99; i >= 0; i--) begin
      sum[i] <= a[i] + b[i] + carry[i];
      carry[i - 1] <= (sum[i] >= 2'b10);
    end
  end

endmodule