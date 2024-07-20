module top_module(
  input clk,
  input [7:0] d,
  output reg [7:0] q);
  
  always @(posedge clk) begin
    q <= d; // store data input in the register on rising edge of the clock
  end
  
endmodule
