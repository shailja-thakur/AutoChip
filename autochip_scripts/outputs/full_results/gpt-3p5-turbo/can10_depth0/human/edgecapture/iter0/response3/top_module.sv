module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      out <= 0; // reset the output register
    end else begin
      out <= out & (~in); // capture the changes from 1 to 0
    end
  end
  
endmodule
