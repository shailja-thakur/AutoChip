module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum;
	reg sign_a, sign_b;

	assign s = sum[7:0];
	assign overflow = sum[8];

	always @(*) begin
		if (a[7] == b[7])
			sign_a = a[7];
		else
			sign_a = 0;

		sign_b = b[7];
	end

	always @(a or b) begin
		if (sign_a == 1)
			sum = a * -1;
		else
			sum = a;

		if (sign_b == 1)
			sum = sum + (b * -1);
		else
			sum = sum + b;
	end

endmodule
