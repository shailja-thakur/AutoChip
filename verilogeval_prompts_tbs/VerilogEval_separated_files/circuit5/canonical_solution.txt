
	always @(*) 
		case (c)
			0: q = b;
			1: q = e;
			2: q = a;
			3: q = d;
			default: q = 4'hf;
		endcase
	
endmodule
