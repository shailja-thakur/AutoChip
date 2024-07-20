module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk)
begin
	if (q == 0 && a == 0)
	begin
		q <= 0; 
	end
	else if (q == 0 && a == 1)
	begin
		q <= 1; 
	end
	else if (q == 1 && a == 0)
	begin
		q <= 1; 
	end
	else if (q == 1 && a == 1)
	begin
		q <= 0; 
	end
	else if (q == 2 && a == 0)
	begin
		q <= 0; 
	end
	else if (q == 2 && a == 1)
	begin
		q <= 1; 
	end
	else if (q == 3 && a == 0)
	begin
		q <= 1; 
	end
	else if (q == 3 && a == 1)
	begin
		q <= 1; 
	end
	else
	begin
		q <= 0; 
	end
end

endmodule
