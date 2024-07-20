module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

  // Create 8 D flip-flops with active high asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset)
      q <= 8'b0;
    else
      q <= d;
  end

endmodule
