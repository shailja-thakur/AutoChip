module top_module (
	input clk,
	input d,
	input ar,
	output q
);
 
always_ff @(posedge clk or negedge ar) begin
	if (~ar) // asynchronous reset
		q <= 1'b0;
	else // positive edge triggered
		q <= d;
end
 
endmodule
