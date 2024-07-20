module top_module(
  input clk,
  input d,
  output reg q);

  // Initialize the register q to an unknown value
  initial begin
    q = 1'hx;
  end

  // Always block triggered by rising edge of the clock signal
  always @(posedge clk) begin
    q <= d; // Assign the value of d to q at the rising edge of the clock
  end

endmodule
