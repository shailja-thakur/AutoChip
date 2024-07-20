module top_module (
	input wire a, 
	input wire b, 
	output reg q
);

always @(*)
begin
	if(a && ~b)
		q <= 0;
	else if(~a && b)
		q <= 0;
	else if(a && b)
		q <= 1;
	else
		q <= 0;
end

endmodule
