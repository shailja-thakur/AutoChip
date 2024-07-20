module top_module(
  input clk,
  input reset,
  output reg [9:0] q);

  always @(posedge clk) begin
    if (reset == 1) begin // check if reset is active (high)
      q <= 0; // reset output register to 0
    end
    else if (q < 999) begin // check if output register is less than 999
      q <= q + 1; // increment output register by 1
    end
    else begin
      q <= 0; // reset output register to 0 if it reaches 999
    end
  end

endmodule
