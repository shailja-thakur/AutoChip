module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	// When `a` is 1, `q` is set to 4
	if (a == 1) begin
		q <= 3'b100;
	end else begin
		// Increment `q` when `a` is 0, wrapping around at 6 (reset to 0, 1, 2, and so on)
		if (q == 3'b110) begin
			q <= 3'b000;
		end else begin
			q <= q + 3'b001;
		end
	end
end

endmodule
