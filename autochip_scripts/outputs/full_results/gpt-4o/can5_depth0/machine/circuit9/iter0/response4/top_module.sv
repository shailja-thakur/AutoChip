module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1) 
		q <= 3'b100;  // set q to 4
	else if (q == 3'b110)
		q <= 3'b000;  // reset q to 0 if q is 6
	else
		q <= q + 1;  // increment q when a is 0 and q is not 6
end

endmodule
