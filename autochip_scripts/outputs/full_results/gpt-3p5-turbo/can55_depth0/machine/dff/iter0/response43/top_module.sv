module top_module(
  input clk,
  input d,
  output reg q
);

  // Synchronize the data signal with the clock signal
  always @(posedge clk) begin
    q <= d;
  end

endmodule
