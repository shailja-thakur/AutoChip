module top_module(
   input clk,
   input [7:0] d,
   output reg [7:0] q);

   always @(posedge clk) begin
      q <= d;   // Store the data input in the register on the rising edge of the clock input
   end
endmodule
