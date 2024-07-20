module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	if (c == 0) begin
		if (a == 0 && b == 0 || a == 0 && b == 1) begin
			out <= 0;
		end else if (a == 1 && b == 0 || a == 1 && b == 1) begin
			out <= 1;
		end else begin
			out <= d;
		end
	end else if (c == 1) begin
		if (a == 1 || a == 0 && b == 0 || a == 0 && b == 1) begin
			out <= 1;
		end
	end
end

endmodule
