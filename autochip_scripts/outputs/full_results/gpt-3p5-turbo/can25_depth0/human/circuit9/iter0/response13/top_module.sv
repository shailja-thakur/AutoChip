module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

   // Always block to update q based on clk and a
   always @(posedge clk) begin
      if (a == 1'b1) begin
         q <= q + 1;
      end
   end

endmodule
