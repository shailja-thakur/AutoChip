module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q);

  reg [7:0] q_;

  always @(posedge clk or posedge areset) begin
    if (areset)
      q_ <= 8'b0;
    else
      q_ <= d;
  end

  always @(posedge clk) begin
    q <= q_;
  end

endmodule
