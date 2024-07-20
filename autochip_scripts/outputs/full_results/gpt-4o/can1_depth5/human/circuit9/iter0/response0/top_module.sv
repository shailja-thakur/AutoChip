module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a) begin
		q <= 3'b100; // When 'a' is 1, set q to 4
	end else begin
		if (q == 3'b110) // If q is 6, reset to 0
			q <= 3'b000;
		else
			q <= q + 1; // Otherwise, increment q by 1
	end
end

endmodule
