
	always_comb  begin
		out = 0;
		for (int i=0;i<255;i++)
			out = out + in[i];
	end
	
endmodule
