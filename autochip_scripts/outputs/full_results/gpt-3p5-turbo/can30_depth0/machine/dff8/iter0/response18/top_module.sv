module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q);

  // Register initialization
  reg [7:0] register = 8'h0;

  always @(posedge clk) begin
    register <= d; // Store data input in the register
    q <= register; // Output the stored data
  end

endmodule
