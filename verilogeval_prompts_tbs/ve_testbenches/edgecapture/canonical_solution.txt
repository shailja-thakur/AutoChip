	
	reg [31:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;
		if (reset)
			out <= '0;
		else
			out <= out | (~in & d_last);
	end
	
endmodule
