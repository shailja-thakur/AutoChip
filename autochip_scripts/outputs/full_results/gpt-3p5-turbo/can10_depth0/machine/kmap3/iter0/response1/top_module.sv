module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
	if (a==0 && b==0 && c==0 && d==0) 
		out = 0;
	else if (a==1 && b==1 && c==1 && d==1)
		out = 0;
	else if ((a==0 || a==1) && (b==3 || b==2) && (c==3 || c==2) && (d==3 || d==2))
		out = 1;
	else if ((a==0 || a==1) && (b==4 || b==5) && (c==4 || c==5) && (d==4 || d==5))
		out = 1'bx;
	else if ((a==0 || a==1) && (b==7 || b==6) && (c==7 || c==6) && (d==7 || d==6))
		out = 0;
	else if ((a==0 || a==1) && (b==c || b==d) && (c==c || c==d) && (d==c || d==d))
		out = 1;
	else if ((a==0 || a==1) && (b==5 || b==4) && (c==5 || c==4) && (d==5 || d==4))
		out = 0;
	else if ((a==0 || a==1) && (b==a || b==b) && (c==a || c==b) && (d==a || d==b))
		out = 1;
	else
		out = 1;
end
    
endmodule
