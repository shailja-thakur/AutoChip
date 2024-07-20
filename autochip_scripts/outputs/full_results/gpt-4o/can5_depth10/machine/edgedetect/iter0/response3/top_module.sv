module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge);

  reg [7:0] d_last;

  always @(posedge clk) begin
    // Store the current value of the input signal
    d_last <= in;

    // Calculate the rising edge detection
    pedge <= in & ~d_last;
  end

endmodule
