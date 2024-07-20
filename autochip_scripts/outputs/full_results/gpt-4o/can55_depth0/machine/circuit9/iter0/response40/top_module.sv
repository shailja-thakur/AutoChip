module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk)
begin
	if(a)
		q <= 3'b100; // Set q to 4
	else if(q == 3'b110)
		q <= 3'b000; // Set q to 0 when q is 6
	else
		q <= q + 3'b001; // Increment q
end

endmodule
