module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] in_reg; // Register to store the previous value of input

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         out <= 0;
         in_reg <= 0;
      end else begin
         in_reg <= in;
         out <= out | (in_reg ^ (in_reg & (in_reg >> 1)));
      end
   end

endmodule
