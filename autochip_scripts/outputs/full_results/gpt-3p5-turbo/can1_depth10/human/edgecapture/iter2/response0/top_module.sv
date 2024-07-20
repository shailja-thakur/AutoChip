module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] in_reg;
   reg [31:0] in_reg_prev;
   reg [31:0] in_reg_next;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         out <= 0;
         in_reg <= 0;
         in_reg_prev <= 0;
         in_reg_next <= 0;
      end else begin
         in_reg <= in;
         in_reg_prev <= in_reg;
         in_reg_next <= {in_reg[30:0], 1'b0};

         out <= (in_reg_prev & ~in_reg_next);
      end
   end

endmodule
