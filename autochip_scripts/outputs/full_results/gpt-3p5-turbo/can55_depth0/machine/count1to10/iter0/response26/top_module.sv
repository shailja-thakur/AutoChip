module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

  always @(posedge clk) begin
    if (reset) begin
      q <= 4'b1;  // Set the output register to 1
    end else if (q == 4'b1010) begin
      q <= 4'b1;  // Reset the output register to 1 when it reaches 10
    end else begin
      q <= q + 4'b1; // Increment the output register by 1
    end
  end

endmodule
