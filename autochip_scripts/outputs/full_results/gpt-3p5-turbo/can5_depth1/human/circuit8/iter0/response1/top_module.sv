module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

   reg p_next, q_next;

   always @(posedge clock) begin
      p <= p_next;
      q <= q_next;

      if (a) begin
         p_next <= p;
         q_next <= q;
      end
      else if (p & q) begin
         p_next <= 0;
         q_next <= 1;
      end
      else begin
         p_next <= p;
         q_next <= q;
      end
   end

endmodule
