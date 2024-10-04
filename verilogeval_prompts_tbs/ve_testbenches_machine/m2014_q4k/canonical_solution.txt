
	reg [3:0] sr;
	always @(posedge clk) begin
		if (~resetn)
			sr <= '0;
		else 
			sr <= {sr[2:0], in};
	end
	
	assign out = sr[3];
	

endmodule
