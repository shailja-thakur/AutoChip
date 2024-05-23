	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;
		anyedge <= in ^ d_last;
	end
	
endmodule
