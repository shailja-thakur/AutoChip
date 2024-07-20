module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q);

  reg [7:0] ff [7:0];

  always @(posedge clk) begin
    for (int i = 0; i < 8; i = i + 1) begin
      ff[i] <= d[i];
    end
  end

  always @* begin
    q = ff;
  end

endmodule
