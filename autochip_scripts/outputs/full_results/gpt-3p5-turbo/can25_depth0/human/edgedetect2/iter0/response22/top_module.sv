module top_module (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  // Declare a temporary register to store the previous value of the input
  reg [7:0] prev_in;

  always @(posedge clk) begin
    // Update the anyedge output based on the edge detection logic
    anyedge <= (in ^ prev_in) & in;
    // Save the current input value in the prev_in register
    prev_in <= in;
  end
endmodule
