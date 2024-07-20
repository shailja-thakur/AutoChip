module top_module(
	output reg out);
	
	always @(posedge clk or negedge rstn) begin
	  if (!rstn) begin
	    out <= 0; // logic low
	  end
	end
	
endmodule
