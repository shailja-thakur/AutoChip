module top_module(
  input clk,
  input reset,
  output reg [3:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;  // Reset the counter to 0
    end else begin
      if (q == 9) begin
        q <= 0;  // Reset the counter to 0 when it reaches 9
      end else begin
        q <= q + 1;  // Increment the counter by 1
      end
    end
  end

endmodule
