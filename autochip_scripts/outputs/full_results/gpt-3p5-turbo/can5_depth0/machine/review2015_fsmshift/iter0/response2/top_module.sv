module top_module(
	input clk,
	input reset,
	output reg shift_ena);
           
   reg [2:0] state;

   always @(posedge clk) begin
      if (reset == 1) begin
         state <= 3'b0;
      end else if (state == 3'b0) begin
         state <= 3'b1;
      end else if (state == 3'b1) begin
         state <= 3'b10;
      end else if (state == 3'b10) begin
         state <= 3'b11;
      end else if (state == 3'b11) begin
         state <= 3'b100;
      end
   end

   assign shift_ena = (state == 3'b0) || (state == 3'b1) || (state == 3'b10) || (state == 3'b11);

endmodule
