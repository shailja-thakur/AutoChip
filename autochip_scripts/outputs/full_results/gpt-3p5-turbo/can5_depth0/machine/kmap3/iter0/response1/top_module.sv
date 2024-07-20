module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
	if (a==0 && b==0 && c==0 && d==0)       // if a,b,c,d == 0
		out = 0;
	else if (a==1 && b==1 && c==1 && d==1)  // if a,b,c,d == 1
		out = 0;
	else if (a==0 && b==0 && c==0 && d==3)  // if a,b,c,d == 3
		out = 1;
	else if (a==0 && b==0 && c==0 && d==2)  // if a,b,c,d == 2
		out = 1;
	else if (a==0 && b==0 && c==0 && d==4)  // if a,b,c,d == 4
		out = 1'bx;
	else if (a==0 && b==0 && c==0 && d==5)  // if a,b,c,d == 5
		out = 0;
	else if (a==0 && b==0 && c==0 && d==7)  // if a,b,c,d == 7
		out = 0;
	else if (a==0 && b==0 && c==0 && d==6)  // if a,b,c,d == 6
		out = 0;
	else if (a==0 && b==0 && c==0 && d==c)  // if a,b,c,d == c
		out = 1;
	else if (a==0 && b==0 && c==0 && d==d)  // if a,b,c,d == d
		out = 1'bx;
	else if (a==0 && b==0 && c==0 && d==f)  // if a,b,c,d == f
		out = 1;
	else if (a==0 && b==0 && c==0 && d==e)  // if a,b,c,d == e
		out = 1;
	else if (a==0 && b==0 && c==0 && d==8)  // if a,b,c,d == 8
		out = 1;
	else if (a==0 && b==0 && c==0 && d==9)  // if a,b,c,d == 9
		out = 1'bx;
	else if (a==0 && b==0 && c==0 && d==b)  // if a,b,c,d == b
		out = 1;
	else if (a==0 && b==0 && c==0 && d==a)  // if a,b,c,d == a
		out = 1;
end

endmodule
