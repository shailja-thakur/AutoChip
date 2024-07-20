module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] in_reg;
   reg [31:0] in_reg_prev;
   reg [31:0] out_reg;
   reg [31:0] out_reg_last;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         out_reg <= 0;
         in_reg <= 0;
         in_reg_prev <= 0;
         out_reg_last <= 0;
      end else begin
         in_reg_prev <= in_reg;
         in_reg <= in;

         out_reg <= in_reg_prev & ~in_reg;

         if (out_reg != 0) begin
            out_reg_last <= out_reg;
         end
      end
   end

   always @(posedge clk) begin
      if (reset) begin
         out <= 0;
      end else begin
         out <= out_reg_last;
      end
   end

endmodule
