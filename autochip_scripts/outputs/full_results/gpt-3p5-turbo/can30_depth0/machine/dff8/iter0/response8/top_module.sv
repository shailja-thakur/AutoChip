module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q );

  always @(posedge clk) begin
    q <= d; // Store the data input in the register
  end

  initial begin
    q <= 8'h0; // Set the initial value of the output to 8'h0
  end

endmodule
