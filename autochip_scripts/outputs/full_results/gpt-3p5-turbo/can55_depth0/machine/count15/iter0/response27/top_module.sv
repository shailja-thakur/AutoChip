module top_module(
  input clk,
  input reset,
  output reg [3:0] q);

  // Declare internal wires and registers
  reg [3:0] counter;

  // Always block to increment the counter on the rising edge of clk
  always @(posedge clk) begin
    // Check if reset is asserted
    if (reset) begin
      counter <= 0;  // Reset the counter to 0
    end else begin
      counter <= counter + 1;  // Increment the counter by 1
    end
  end

  // Assign the value of counter to q output
  assign q = counter;

endmodule
