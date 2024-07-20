module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);
	
	always @(a or b or c or d)
	begin
		if(a == 0 && b == 0)
		begin
			if(c == 0 && d == 0)
				out <= 0;
			else if(c == 0 && d == 1)
				out <= 1;
			else if(c == 1 && d == 1)
				out <= 0;
			else if(c == 1 && d == 0)
				out <= 1;
		end
		else if(a == 0 && b == 1)
		begin
			if(c == 0 && d == 0)
				out <= 1;
			else if(c == 0 && d == 1)
				out <= 0;
			else if(c == 1 && d == 1)
				out <= 1;
			else if(c == 1 && d == 0)
				out <= 0;
		end	
		else if(a == 1 && b == 1)
		begin
			if(c == 0 && d == 0)
				out <= 0;
			else if(c == 0 && d == 1)
				out <= 1;
			else if(c == 1 && d == 1)
				out <= 0;
			else if(c == 1 && d == 0)
				out <= 1;
		end
		else if(a == 1 && b == 0)
		begin
			if(c == 0 && d == 0)
				out <= 1;
			else if(c == 0 && d == 1)
				out <= 0;
			else if(c == 1 && d == 1)
				out <= 1;
			else if(c == 1 && d == 0)
				out <= 0;
		end	
	end
	
endmodule
