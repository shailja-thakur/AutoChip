module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] in_reg;
   reg [31:0] in_reg_prev;
   reg [31:0] out_reg;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         out_reg <= 0;
         in_reg <= 0;
         in_reg_prev <= 0;
      end else begin
         in_reg_prev <= in_reg;
         in_reg <= in;

         out_reg <= out_reg | (in_reg_prev & ~in_reg);
      end
   end

   always @* begin
      out = out_reg;
   end

endmodule
