module top_module (
	input wire d,
	input wire ena,
	output reg q
);
	// Initial value for output
	initial begin
		q = 0;
	end
	
	always @(*) begin
		if (ena) begin
			q = d;
		end
	end
endmodule
