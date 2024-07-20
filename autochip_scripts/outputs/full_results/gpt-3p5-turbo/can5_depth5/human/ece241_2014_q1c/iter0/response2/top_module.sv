module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] sum;
	reg overflow;

	always @ (a or b) begin
		sum = a + b;
		if ((a[7] && b[7] && ~sum[7]) || (~a[7] && ~b[7] && sum[7])) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end
	end

	assign s = sum;

endmodule
