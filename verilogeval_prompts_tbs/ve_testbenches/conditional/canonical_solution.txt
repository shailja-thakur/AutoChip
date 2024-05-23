
	always_comb begin
		min = a;
		if (min > b) min = b;
		if (min > c) min = c;
		if (min > d) min = d;
	end
	
endmodule
