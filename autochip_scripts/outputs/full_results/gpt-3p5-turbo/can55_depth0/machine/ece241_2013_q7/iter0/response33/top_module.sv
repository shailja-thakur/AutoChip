module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);
   always @(posedge clk) begin
	  if(j && !Q) begin
		 Q <= j;
	  end else if(!k && Q) begin
		 Q <= 0;
	  end else if(j && k) begin
		 Q <= ~Q;
	  end
   end
endmodule
