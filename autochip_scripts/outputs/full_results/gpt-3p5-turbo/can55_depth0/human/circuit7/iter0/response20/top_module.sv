module top_module (
	input clk,
	input a, 
	output reg q
);

   reg q_temp;

   always @(posedge clk) begin
      if (a & ~q_temp) begin
         q <= 1'b1;
      end else if (~a & q_temp) begin
         q <= 1'b0;
      end
      q_temp <= q;
   end

endmodule
