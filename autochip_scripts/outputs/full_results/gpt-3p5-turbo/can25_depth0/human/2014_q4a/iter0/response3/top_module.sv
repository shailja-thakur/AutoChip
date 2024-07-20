module top_module (
   input clk,
   input w,
   input R,
   input E,
   input L,
   output reg Q
);
	
	reg next_Q;
	
	always @(posedge clk) begin
	   if (E) begin
	      if (L) begin
	         next_Q <= R;
	      end
	      else begin
	         next_Q <= Q;
	      end
	   end
	   else begin
	      next_Q <= Q;
	   end
	end
	
	always @(posedge clk) begin
	   if (E) begin
	      Q <= next_Q;
	   end
	end
	
	always @(posedge clk) begin
	   if (E) begin
	      if (L) begin
	         Q <= R;
	      end
	      else begin
	         Q <= w;
	      end
	   end
	end
	
endmodule
