module top_module (
   input clk,
   input reset,
   output reg [31:0] q
);

   reg [31:0] shift_reg = 32'b1;

   always @(posedge clk) begin
      if (reset == 1'b1) begin
         shift_reg <= 32'b1;
      end else begin
         shift_reg[31] <= shift_reg[22] ^ shift_reg[2] ^ shift_reg[1] ^ shift_reg[0];
         shift_reg[30:0] <= shift_reg[31:1];
      end
   end

   assign q = shift_reg;

endmodule
