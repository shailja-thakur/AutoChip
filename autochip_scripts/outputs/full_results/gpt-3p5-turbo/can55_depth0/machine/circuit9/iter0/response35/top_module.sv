module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	if(a) begin
		// When a is 1, q is set to 4.
		q <= 3'b100;
	end
	else begin
		if(q == 3'b110) begin
			// When a is 0 and q is 6, q is set to 0.
			q <= 3'b000;
		end
		else begin
			// When a is 0 and q is not 6, q is increased by 1.
			q <= q + 1;
		end
	end
end

endmodule
