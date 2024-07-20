module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

   reg [3:0] shift_reg;
   reg [3:0] next_shift_reg;
   integer dec_count;
   reg enable;

   always @(posedge clk) begin
      if (count_ena && enable) begin
         if (dec_count == 0) begin
            dec_count = 9;
            next_shift_reg = shift_reg - 1;
         end else begin
            dec_count = dec_count - 1;
            next_shift_reg = shift_reg;
         end
      end else begin
         dec_count = 9;
         next_shift_reg = shift_reg;
      end

      if (shift_ena) begin
         next_shift_reg[3] = data;
         next_shift_reg[2:0] = shift_reg[3:1];
      end

      if (count_ena != shift_ena) begin
         shift_reg <= next_shift_reg;
         enable <= 1'b1;
      end else begin
         enable <= 1'b0;
      end
   end
   
   assign q = shift_reg;
   
endmodule
