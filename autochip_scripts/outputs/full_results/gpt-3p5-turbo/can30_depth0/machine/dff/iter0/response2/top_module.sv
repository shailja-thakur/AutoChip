module top_module(
  input clk,
  input d,
  output reg q
);

  // Initialize the register signal q to 1'hx
  reg [0:0] q = 1'hx;

  // Synchronize the data signal d with the clock signal clk
  always @(posedge clk) begin
    q <= d;
  end

endmodule
