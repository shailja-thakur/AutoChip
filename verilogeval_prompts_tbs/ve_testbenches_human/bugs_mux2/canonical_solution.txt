
	// assign out = (~sel & a) | (sel & b);
    assign out = sel ? a : b;
	
endmodule
