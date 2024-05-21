
	initial
		out = 0;
		
	always@(posedge clk) begin
		out <= in ^ out;
	end

endmodule
