module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	always @* begin
		/* Complete your code here */
		if(!a && !b && !c && !d)
		  q = 1;
		else if(!a && !b && !c && d)
		  q = 1;
		else if(!a && !b && c && !d)
		  q = 1;
		else if(a && !b && !c && !d)
		  q = 1;
		else if(!a && b && !c && !d)
		  q = 1;
		else if(!a && b && !c && d)
		  q = 1;
		else if(a && !b && c && !d)
		  q = 1;
		else if(a && b && !c && !d)
		  q = 1;
		else if(a && b && c && d)
		  q = 1;
		else
		  q = 0;
	end
endmodule
