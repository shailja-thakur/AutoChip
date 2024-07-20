module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] in_reg;
   reg [31:0] in_reg_prev;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         out <= 0;
         in_reg <= 0;
         in_reg_prev <= 0;
      end else begin
         in_reg_prev <= in_reg;
         in_reg <= in;

         out <= out | (in_reg_prev & ~in_reg);
      end
   end

endmodule
