module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if (a == 1) begin
		q <= 3'b100;  // Set q to 4 when a is 1
	end
	else if (a == 0) begin
		if (q == 3'b110) begin  // If q is 6, set q to 0
			q <= 3'b000;
		end
		else begin  // Otherwise, increment q by 1
			q <= q + 1;
		end
	end
end

endmodule
