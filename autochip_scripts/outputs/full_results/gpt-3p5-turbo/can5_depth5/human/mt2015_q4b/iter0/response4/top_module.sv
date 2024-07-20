module top_module(
    input x,
    input y,
    output z);

	always @(*) begin
		if (x & y) begin
			z = 1'b1;
		end else begin
			z = 1'b0;
		end
	end

endmodule
